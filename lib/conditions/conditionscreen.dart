import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/conditions/Alert_message.dart';
import 'package:nameconfig/conditions/condition_model.dart';
import 'package:nameconfig/conditions/conditionwebui.dart';
import 'package:nameconfig/const/custom_switch.dart';
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
    'condition',
    'From Hour',
    'Unit Hour',
    'Notification',
    'Used Program',
    'Zone',
    'Program',
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
  String programstr = '';
  String zonestr = '';
  final _formKey = GlobalKey<FormState>();

  

  @override
  void initState() {
    super.initState();
     fetchData();
  }

  Future<void> fetchData() async { 
    Map<String, Object> body = {"userId": '15', "controllerId": '1'};
    final response = await HttpService().postRequest("getUserPlanningConditionLibrary", body);
    print(response);
     if (response.statusCode == 200) {
      setState(() {
        var jsondata1 = jsonDecode(response.body);
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
        dropdowntitle = 'Sensor';
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
  if (usedprogramdropdownlist!.isNotEmpty) {
        if(usedprogramdropdownstr2 == '') {
          usedprogramdropdownstr2 = usedprogramdropdownstr2 == '' ? '${usedprogramdropdownlist?[0].id} (${usedprogramdropdownlist?[0].name})' : usedprogramdropdownstr2;
        } else {
          usedprogramdropdownstr2 = '${usedprogramdropdownlist?[0].id} (${usedprogramdropdownlist?[0].name})';
        }
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

     final hour = _selectedTime.hour.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
   
    // return '${_selectedTime.hour}:${_selectedTime.minute}';
  }

String conditionselection(String name,String id ,String value)
{
    programstr = '';
   zonestr = '';
  String  conditionselectionstr = '';
      if (usedprogramdropdownstr.contains('Program')) {
       var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
        conditionselectionstr = 'Programs $id is ${usedprogramdropdownstrarr[1]}';
        programstr = id;
      }
      if (usedprogramdropdownstr.contains('Sensor')) {
         var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
         conditionselectionstr = 'Sensor $id is ${usedprogramdropdownstrarr[1]} value $value ';
      }
      if (usedprogramdropdownstr.contains('Contact')) {
         var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
        conditionselectionstr = 'Contact $id is ${usedprogramdropdownstrarr[1]}';
      }
      if (usedprogramdropdownstr.contains('Water')) {
         var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
        conditionselectionstr = 'Water Meter $id is ${usedprogramdropdownstrarr[1]} $value';
      }
      if (usedprogramdropdownstr.contains('Conbined')) {
         var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
        conditionselectionstr = '${usedprogramdropdownstrarr[0]} $value';
      }
      if (usedprogramdropdownstr.contains('Zone')) {
        var usedprogramdropdownstrarr = usedprogramdropdownstr.split('is');
        conditionselectionstr = '${usedprogramdropdownstrarr[0]} $value';
        zonestr = name;
      }
   return conditionselectionstr;
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
                     text:  _conditionModel.data!.conditionLibrary![i].name ?? 'Condition',
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
            child: Form(
              key: _formKey,
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
                  //  usedprogramdropdownstr = _conditionModel.data!.conditionLibrary![i].dropdown1.toString();
                  //  usedprogramdropdownstr2 = _conditionModel.data!.conditionLibrary![i].dropdown2.toString();
                  //  valueforwhentrue = _conditionModel.data!.conditionLibrary![i].dropdownvalue.toString();
                   Padding(
                     padding: const EdgeInsets.only(bottom: 50),
                     child: SingleChildScrollView(
                       child: Column(children: [
                       Container(width: double.infinity,height: 40,child:Center(child: Text('${i+1}. ${_conditionModel.data!.conditionLibrary![i].id}')),color: Colors.amber,) ,
                       Card(child: ListTile(title: Text(conditionhdrlist[1]),trailing: Text(_conditionModel.data!.conditionLibrary![i].name.toString()),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[2]),trailing: MySwitch(
                                 value: _conditionModel.data!.conditionLibrary![i].enable ?? false,
                                 onChanged: ((value) {
                                   setState(() {
                                       _conditionModel.data!.conditionLibrary![i].enable = value;
                                    });
                                  }),
                               ),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[3]),trailing: Text(_conditionModel.data!.conditionLibrary![i].state.toString()),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[4]),trailing: Container(
                         child: InkWell(
                                                    child: Text(
                         '${_conditionModel.data!.conditionLibrary![i].duration}',
                         style: const TextStyle(fontSize: 20),
                                                    ),
                                                    onTap: () async{
                         String time =  await _selectTime(context);
                         setState(()  {
                         _conditionModel.data!.conditionLibrary![i].duration = time;
                         });
                                                    },
                                                  ),
                       ),)),
                      //  Card(child: ListTile(title: Text('test',softWrap: true,),trailing: Text(_conditionModel.data!.conditionLibrary![i].conditionIsTrueWhen.toString(),softWrap: true,),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[5]),trailing: Container(width: 200, child: Text(_conditionModel.data!.conditionLibrary![i].conditionIsTrueWhen.toString(),softWrap: true,overflow: TextOverflow.fade,)),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[10]),trailing: Text(_conditionModel.data!.conditionLibrary![i].zone.toString(),softWrap: true,),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[11]),trailing: Text(_conditionModel.data!.conditionLibrary![i].program.toString(),softWrap: true,),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[6]),trailing: InkWell(
                               child: Text(
                       '${_conditionModel.data!.conditionLibrary![i].fromTime}',
                       style: const TextStyle(fontSize: 20), ),
                               onTap: () async{
                       String time =  await _selectTime(context);
                       setState(()  {
                       _conditionModel.data!.conditionLibrary![i].fromTime = time;
                       });   
                               },
                             ),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[7]),trailing: InkWell(
                               child: Text(
                       '${_conditionModel.data!.conditionLibrary![i].untilTime}',
                       style: const TextStyle(fontSize: 20),
                               ),
                               onTap: () async{
                       String time =  await _selectTime(context);
                       setState(()  {
                       _conditionModel.data!.conditionLibrary![i].untilTime = time;
                       });
                               
                               },
                             ),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[8]),trailing:MySwitch(
                                 value: _conditionModel.data!.conditionLibrary![i].notification ?? false,
                                 onChanged: ((value) {
                                   setState(() {
                                       _conditionModel.data!.conditionLibrary![i].notification = value;
                                    });
                                  }),
                               ),)),
                       Card(child: ListTile(title: Text(conditionhdrlist[9]),trailing: Text(_conditionModel.data!.conditionLibrary![i].usedByProgram.toString(),softWrap: true,),)),
                       Card(child: ListTile(title: Text('When Program'),trailing:  DropdownButton(
                        items: _conditionModel.data!.dropdown?.map((String? items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Container(padding: const EdgeInsets.only(left: 10), child: Text(items!)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                               usedprogramdropdownstr = value.toString();
                               _conditionModel.data!.conditionLibrary![i].dropdown1 = value.toString();
                            checklistdropdown();
                          });
                        },
                        value: usedprogramdropdownstr == '' ? _conditionModel.data!.conditionLibrary![i].dropdown1!.isEmpty ? (_conditionModel.data!.dropdown![0]) : _conditionModel.data!.conditionLibrary![i].dropdown1!.toString() : usedprogramdropdownstr,
                      ),)),
                      if(usedprogramdropdownlist?.length != 0) 
                       Card(child: ListTile(title: Text(dropdowntitle),trailing:  DropdownButton(
                          items: usedprogramdropdownlist?.map((UserNames items) {
                            return DropdownMenuItem(
                              value: '${items.id} (${items.name})',
                              child: Container(padding: const EdgeInsets.only(left: 10), child: Text('${items.id} (${items.name})')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                               usedprogramdropdownstr2 = value.toString();
                               _conditionModel.data!.conditionLibrary![i].dropdown2 = value.toString();
                            });
                          },
                         
                          value: usedprogramdropdownstr2 == '' ?  _conditionModel.data!.conditionLibrary![i].dropdown2!.isEmpty ? ('${usedprogramdropdownlist?[0].id} (${usedprogramdropdownlist?[0].name})') : _conditionModel.data!.conditionLibrary![i].dropdown1!.toString()  : usedprogramdropdownstr2,
                        ),)),
                       if(usedprogramdropdownstr.contains('Sensor') || usedprogramdropdownstr.contains('Combined') || usedprogramdropdownstr.contains('Contact'))
                      Card(child: ListTile(title: Text(hint),trailing: Container(
                         height: 40,
                            width: 200,
                        child: TextFormField(
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                initialValue: _conditionModel.data!.conditionLibrary![i].dropdownValue,
                                showCursor: true,
                                decoration: InputDecoration(hintText: hint),
                                onChanged: (value) {
                        valueforwhentrue = value;
                          validator: (value) {
                  if (value == null || value.isEmpty) {
                      valueforwhentrue = '0';
                  }
                  else{
                      valueforwhentrue = value;
                  }
                  return null;
                };
                                },
                              ),
                      ),)),
                                           ]),
                     ),
                   )
              ]),),
            ),
          ),
  
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              setState(() {
                    _conditionModel.data!.conditionLibrary![Selectindexrow].conditionIsTrueWhen = conditionselection(usedprogramdropdownstr,usedprogramdropdownstr2,valueforwhentrue);
                     _conditionModel.data!.conditionLibrary![Selectindexrow].program = programstr;
                     _conditionModel.data!.conditionLibrary![Selectindexrow].zone = zonestr;
                     _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1 = usedprogramdropdownstr;
                     _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown2 = usedprogramdropdownstr2;
                     _conditionModel.data!.conditionLibrary![Selectindexrow].dropdownValue = valueforwhentrue;
                       updateconditions();                 
              });
            },
            tooltip: 'Send',
            child: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
  }
    updateconditions() async
{    
    List<Map<String, dynamic>> conditionJson =  _conditionModel.data!.conditionLibrary!.map((condition) => condition.toJson()).toList();
     
  Map<String, Object> body = {
    "userId": '15',
    "controllerId": "1",
    "condition": conditionJson,
    "createUser": "1"
  };
     final response =
      await HttpService().postRequest("createUserPlanningConditionLibrary", body);
  final jsonDataresponse = json.decode(response.body);
   AlertDialogHelper.showAlert(context, '', jsonDataresponse['message']);
}

}
