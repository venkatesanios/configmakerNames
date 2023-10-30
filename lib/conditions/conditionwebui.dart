import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nameconfig/conditions/Alert_message.dart';
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
    'condition IsTrueWhen',
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
  String programstr = '';
  String zonestr = '';


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
  void checklistdropdown() async{
     usedprogramdropdownlist = [];
    dropdowntitle = '';
     hint = '';

       if (usedprogramdropdownstr.contains('Program'))  {
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
              child: SingleChildScrollView(
                
                scrollDirection: Axis.horizontal,
                child: Container(   
                  height: double.infinity,
                  width:  1100,
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
                              softWrap: true,
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
                                  else if (conditionhdrlist[i] == 'condition IsTrueWhen')
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
                                  else if (conditionhdrlist[i] == 'Zone')
                                    DataCell(onTap: () { setState(() {
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].zone}',  )))
                                  else if (conditionhdrlist[i] == 'Program')
                                    DataCell(onTap: () { setState(() { 
                                      Selectindexrow = index;
                                    }); },Center(
                                        child: Text( '${_conditionModel.data!.conditionLibrary![index].program}',  )))
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
                    if(Selectindexrow != null)
                        //  changeval(),
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
                           //   print(jsonEncode(_conditionModel.data!.dropdown));
                        });
                      },
                        value: usedprogramdropdownstr == '' ? _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1!.isEmpty ? (_conditionModel.data!.dropdown![0]) : _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1!.toString() : usedprogramdropdownstr,
                    ),
                    if(usedprogramdropdownlist?.length != 0) 
                       Text(dropdowntitle), 
                    if(usedprogramdropdownstr2.isNotEmpty) 
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
                          value: usedprogramdropdownstr2 == '' ?  _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown2!.isEmpty ? ('${usedprogramdropdownlist?[0].id} (${usedprogramdropdownlist?[0].name})') : _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1!.toString()  : usedprogramdropdownstr2,
                      ),
                    if(usedprogramdropdownstr.contains('Sensor') || usedprogramdropdownstr.contains('Combined') || usedprogramdropdownstr.contains('Contact'))
                          Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                              child: TextFormField(
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                initialValue: _conditionModel.data!.conditionLibrary![Selectindexrow].dropdownValue,
                                showCursor: true,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],

                                decoration: InputDecoration(hintText: hint,border: OutlineInputBorder()),
                                onChanged: (value) {
                        valueforwhentrue = value;
                                 },
                              ),),
                        ),
                        const SizedBox(height: 20,),  
                  ElevatedButton(onPressed: (){
                      setState(() {
                         _conditionModel.data!.conditionLibrary![Selectindexrow].conditionIsTrueWhen = conditionselection(usedprogramdropdownstr,usedprogramdropdownstr2,valueforwhentrue);
                        _conditionModel.data!.conditionLibrary![Selectindexrow].program = programstr;
                        _conditionModel.data!.conditionLibrary![Selectindexrow].zone = zonestr;
                        _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1 = usedprogramdropdownstr;
                        _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown2 = usedprogramdropdownstr2;
                        _conditionModel.data!.conditionLibrary![Selectindexrow].dropdownValue = valueforwhentrue;
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

 changeval (){
             usedprogramdropdownstr = _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown1!;
             usedprogramdropdownstr2 = _conditionModel.data!.conditionLibrary![Selectindexrow].dropdown2!;
             valueforwhentrue = _conditionModel.data!.conditionLibrary![Selectindexrow].dropdownValue!;
             checklistdropdown();
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
  AlertDialogHelper.showAlert(context, '', jsonDataresponse['message']);
  // print("jsonDataresponse:- ${jsonDataresponse['message']} ");
}

}