import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/conditions/condition_model.dart';
import 'package:nameconfig/conditions/conditionwebui.dart';
 import 'package:nameconfig/service/http_services.dart';

class ConditionScreenWidget extends StatefulWidget {
  const ConditionScreenWidget({Key? key});

  @override
  State<ConditionScreenWidget> createState() => _ConditionScreenWidgetState();
}

class _ConditionScreenWidgetState extends State<ConditionScreenWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          // Render mobile content
          return ConditionUI();
        } else {
          // Render web content
          return  ConditionwebUI();
        }
      },
    );
  }
}

class ConditionUI extends StatefulWidget {
  const ConditionUI({Key? key});

  @override
  State<ConditionUI> createState() => _ConditionUIState();
}

class _ConditionUIState extends State<ConditionUI> with TickerProviderStateMixin {
   dynamic jsondata;
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<String> conditionhdrlist = [
    'ID',
    'Name',
    'Enable',
    'State',
    'Duration',
    'Contion with',
    'From Hour',
    'Unit Hour',
    'Notification',
    'Used Program',
   ];
  String usedprogramdropdownstr = '';
  List<UserNames>? usedprogramdropdownlist = [];
  String usedprogramdropdownstr2 = '';
  ConditionModel _conditionModel = ConditionModel();
  String hint = 'Enter Flow Values';
  String dropdowntitle = '';
  String valueforwhentrue = '';
  int Selectindexrow = 0;
  int tabclickindex = 0;

  @override
  void initState() {
    super.initState();
     fetchData();
  }

  Future<void> fetchData() async { 
    Map<String, Object> body = {"userId": '8', "controllerId": '1'};
    final response = await HttpService().postRequest("getUserPlanningCondition", body);
     if (response.statusCode == 200) {
      setState(() {
        var jsondata1 = jsonDecode(response.body);
        print('jsondata1 $jsondata1');
        _conditionModel = ConditionModel.fromJson(jsondata1);
   _conditionModel.data!.dropdown!.insert(0, '');
      });
    } else {
      //_showSnackBar(response.body);
    }
  }

    @override  void checklistdropdown() {
    setState(() {
      if (usedprogramdropdownstr.contains('Program')) {
        usedprogramdropdownlist = _conditionModel.data!.program;
        dropdowntitle = 'Program';
        hint = 'Programs';
      }
      if (usedprogramdropdownstr.contains('Contact')) {
        usedprogramdropdownlist = _conditionModel.data!.contact;
        dropdowntitle = 'Contact';
        hint = 'Contacts';
      }
      if (usedprogramdropdownstr.contains('Sensor')) {
        usedprogramdropdownlist = _conditionModel.data!.analogSensor;
        dropdowntitle = 'Value';
        hint = 'Values';
      }
      if (usedprogramdropdownstr.contains('Water')) {
        usedprogramdropdownlist = _conditionModel.data!.waterMeter;
        dropdowntitle = 'Water Meter';
        hint = 'Flow';
      }
      if (usedprogramdropdownstr.contains('Conbined')) {
        usedprogramdropdownlist = _conditionModel.data!.waterMeter;
         dropdowntitle = 'Expression';
         hint = 'Expression';
      }
    });
  }

  Future<String> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
         _selectedTime = picked;
     }
    return '${_selectedTime.hour}:${_selectedTime.minute}';
  }


  @override
  Widget build(BuildContext context) {
     if (_conditionModel.data == null) {
      return Center(child: CircularProgressIndicator()); // Or handle the null case in a way that makes sense for your application
    } else {
    return DefaultTabController(
      length: _conditionModel.data!.conditionLibrary!.length ?? 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Conditions Library'),
            backgroundColor: Color.fromARGB(255, 31, 164, 231),
            bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 175, 73, 73),
            isScrollable: true,
            tabs: [
              for (var i = 0; i <  _conditionModel.data!.conditionLibrary!.length; i++)
                Tab(
                  text:  _conditionModel.data!.conditionLibrary![i].name,
                ),
            ],
         onTap: (value) {
                      setState(() {
                        tabclickindex = value;
                      });
                      
                    },
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
               decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),  
                ),
              ],
            ),
              child: TabBarView(children: [
              for (var i = 0; i <  _conditionModel.data!.conditionLibrary!.length; i++)
                 Expanded(child:
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SingleChildScrollView(
                              child: Column(children: [
                               Container(width: double.infinity,height: 40,child:Center(child: Text('${i+1}. ${_conditionModel.data!.conditionLibrary![i].id}')),color: Colors.amber,) ,
                              Card(child: ListTile(title: Text(conditionhdrlist[1]),trailing: Text(_conditionModel.data!.conditionLibrary![i].name.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[2]),trailing: Text(_conditionModel.data!.conditionLibrary![i].enable.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[3]),trailing: Text(_conditionModel.data!.conditionLibrary![i].state.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[4]),trailing: Text(_conditionModel.data!.conditionLibrary![i].duration.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[5]),trailing: Text(_conditionModel.data!.conditionLibrary![i].conditionIsTrueWhen.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[6]),trailing: Text(_conditionModel.data!.conditionLibrary![i].fromTime.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[7]),trailing: Text(_conditionModel.data!.conditionLibrary![i].untilTime.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[8]),trailing: Text(_conditionModel.data!.conditionLibrary![i].notification.toString()),)),
                              Card(child: ListTile(title: Text(conditionhdrlist[9]),trailing: Text(_conditionModel.data!.conditionLibrary![i].usedByProgram.toString()),)),
                              ]),
                            ),
                          ),
                         )
            ]),),
          ),
  
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Map<String, Object> body = {
                "userId": '1',
                "controllerId": "1",
                "userNameList": jsondata,
                "createUser": "1"
              };
              print(body);
              final response =
                  await HttpService().postRequest("createUserName", body);
              final jsonData = json.decode(response.body);
            },
            tooltip: 'Send',
            child: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
  }

}
