import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/conditions/condition_model.dart';
import 'package:nameconfig/const/custom_switch.dart';
import 'package:nameconfig/service/http_services.dart';
import 'package:data_table_2/data_table_2.dart';

class ConditionwebUI extends StatefulWidget {
  const ConditionwebUI({Key? key});

  @override
  State<ConditionwebUI> createState() => _ConditionwebUIState();
}

class _ConditionwebUIState extends State<ConditionwebUI> with TickerProviderStateMixin {
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

  Widget build(BuildContext context) {
         if (_conditionModel.data == null) {
      return Center(child: CircularProgressIndicator()); // Or handle the null case in a way that makes sense for your application
    } else {
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conditions Library'),
          backgroundColor: const Color.fromARGB(255, 31, 164, 231),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Container(   
                  child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 580,
                      columns: [
                        for (int i = 0; i < conditionhdrlist.length; i++)
                          DataColumn2(
                            label: Center(
                                child: Text(
                              conditionhdrlist[i].toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                      ],
                      rows: List<DataRow>.generate(
                          _conditionModel.data!.conditionLibrary!.length,
                          (index) => DataRow(color: MaterialStateColor.resolveWith((states) {
        if (index == Selectindexrow) {
          return Colors.blue.withOpacity(0.5); // Selected row color
        }
        return Color.fromARGB(0, 176, 35, 35); 
      }),
                            cells: [
                                 for (int i = 0; i < conditionhdrlist.length; i++)
                                  if (conditionhdrlist[i] == 'Enable')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },
                                      MySwitch(
                                        value: _conditionModel.data!.conditionLibrary![index].enable ?? false,
                                        onChanged: ((value) {
                                          setState(() {
                                            Selectindexrow = index;
                                             _conditionModel.data!.conditionLibrary![index].enable = value;
                                           });
                                         }),
                                      ),
                                    )
                                  else if (conditionhdrlist[i] == 'Notification')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },
                                      MySwitch(
                                        value: _conditionModel.data!.conditionLibrary![index].notification ?? false,
                                        onChanged: ((value) {
                                          setState(() {
                                             Selectindexrow = index;
                                             _conditionModel.data!.conditionLibrary![index].notification = value;
                                           });
                                         }),
                                      ),
                                    )
                                  else if (conditionhdrlist[i] == 'Duration')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: InkWell(
                                      child: Text(
                                        '${_conditionModel.data!.conditionLibrary![index].duration}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      onTap: () async{
                                        String time =  await _selectTime(context);
                                        setState(()  {
                                           Selectindexrow = index;
                                       _conditionModel.data!.conditionLibrary![index].duration = time;
                                        });
                                      
                                      },
                                    )))
                                  else if (conditionhdrlist[i] == 'Unit Hour')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: InkWell(
                                      child: Text(
                                        '${_conditionModel.data!.conditionLibrary![index].untilTime}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                         onTap: () async{
                                        String time =  await _selectTime(context);
                                        setState(()  {
                                           Selectindexrow = index;
                                       _conditionModel.data!.conditionLibrary![index].untilTime = time;
                                        });
                                      
                                      },
                                    )))
                                  else if (conditionhdrlist[i] == 'From Hour')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: InkWell(
                                      child: Text(
                                        '${_conditionModel.data!.conditionLibrary![index].fromTime}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                        onTap: () async{
                                        String time =  await _selectTime(context);
                                        setState(()  {
                                           Selectindexrow = index;
                                       _conditionModel.data!.conditionLibrary![index].fromTime = time;
                                        });
                                      
                                      },
                                    )))
                                  else if (conditionhdrlist[i] == 'ID')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].id}',  )))
                                  else if (conditionhdrlist[i] == 'Name')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].name}',  )))
                                  else if (conditionhdrlist[i] == 'Contion with')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Container(
                                          child: Text(  '${_conditionModel.data!.conditionLibrary![index].conditionIsTrueWhen}', ),
                                        )))
                                  else if (conditionhdrlist[i] == 'State')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].state}', )))
                                  else if (conditionhdrlist[i] == 'Used Program')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },
                                      Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].usedByProgram}', )))
                                  
                                  else
                                     DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },
                                      Center(
                                        child: Text( 'data',)))
                              ], 
      //                          onSelectChanged: (isSelected) {
      //    print('Row $index selected: $isSelected');
      // },
                              )
                              ))),
            ),
            Flexible(
                child: Padding(
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
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.amber,
                      child: const Center(
                          child: Text(
                        'Used Program',
                      )),
                    ),
                    const Text('When'), 
                    DropdownButton(
                      items: _conditionModel.data!.dropdown?.map((String? items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Container(padding: const EdgeInsets.only(left: 10), child: Text(items!)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                           usedprogramdropdownstr = value.toString();
                          checklistdropdown();
                        });
                      },
                      value: usedprogramdropdownstr == '' ? _conditionModel.data!.dropdown![0] : usedprogramdropdownstr,
                    ),
                    if(usedprogramdropdownlist?.length != 0) 
                       Text(dropdowntitle), 
                    if(usedprogramdropdownlist?.length != 0) 

                      
                      DropdownButton(
                        items: usedprogramdropdownlist?.map((UserNames items) {
                          return DropdownMenuItem(
                            value: '${items.id} (${items.name})',
                            child: Container(padding: const EdgeInsets.only(left: 10), child: Text('${items.id} (${items.name})')),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                             usedprogramdropdownstr2 = value.toString();
                          });
                        },
                        value: usedprogramdropdownstr2 == '' ? '${usedprogramdropdownlist?[0].id} (${usedprogramdropdownlist?[0].name})' : usedprogramdropdownstr2,
                      ),
                    if(usedprogramdropdownstr.contains('Sensor') || usedprogramdropdownstr.contains('Combined') || usedprogramdropdownstr.contains('Contact'))
                          Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: TextField(
                            showCursor: true,
                            decoration: InputDecoration(hintText: hint),
                            onChanged: (value) {
                              valueforwhentrue = value;
                            },
                          )),
                        ),
                        const SizedBox(height: 20,),  
                  ElevatedButton(onPressed: (){
                     print(valueforwhentrue);
                    setState(() {
                        _conditionModel.data!.conditionLibrary![Selectindexrow].conditionIsTrueWhen = '$usedprogramdropdownstr $usedprogramdropdownstr2 $valueforwhentrue';
                     });
                  }, child: const Text('Apply Changes'))      
                  ],
                ),
              ),
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
              updateconditions();
          },
          tooltip: 'Send',
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
  }
  updateconditions() async
{    
   List<Map<String, dynamic>> conditionJson =  _conditionModel.data!.conditionLibrary!.map((condition) => condition.toJson()).toList();
     
  Map<String, Object> body = {
    "userId": '8',
    "controllerId": "1",
    "condition": conditionJson,
    "createUser": "1"
  };
     final response =
      await HttpService().postRequest("createUserPlanningCondition", body);
  final jsonDataresponse = json.decode(response.body);
  print('jsonDataresponse:- $jsonDataresponse');
}

}