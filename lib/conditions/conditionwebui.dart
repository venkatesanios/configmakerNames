import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:nameconfig/conditions/condition_model.dart';
import 'package:nameconfig/const/custom_switch.dart';
import 'package:nameconfig/const/drop_down_button.dart';
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
  List<String> conditionlist = [
    'con1',
    'con2',
    'con3',
    'con4',
    'con5',
    'con6',
    'con7',
    'con8',
    'con9',
  ];
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
List<String> usedprogramdropdownlist = ['Program Starting',
'Program Ending','Program is Running','Program is Not Running','Contact is opened','Contact is closed','Contact is opening','Contact is closing'];
    String usedprogramdropdownstr2 = '';
List<String> usedprogramdropdownlist2 = ['Program Starting',
'Program Ending','Program is Running','Program is Not Running','Contact is opened','Contact is closed','Contact is opening','Contact is closing'];

 ConditionModel _conditionModel = ConditionModel();
  @override
  void initState() {
    super.initState();
     fetchData();
  }

  Future<void> fetchData() async {
    //  _conditionModel = ConditionModel.fromJson(jsonData);
    Map<String, Object> body = {"userId": '8', "controllerId": '1'};
    final response = await HttpService().postRequest("getUserPlanningCondition", body);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      setState(() {
       var jsondata1 = jsonDecode(response.body);
        _conditionModel = ConditionModel.fromJson(jsondata1);
         print('--jsondata--------$jsondata');
      });
    } else {
      //_showSnackBar(response.body);
    }
  }
    

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conditions Library'),
          backgroundColor: Color.fromARGB(255, 31, 164, 231),
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
                     columns:  [
                                for(int i = 0; i < conditionhdrlist.length;i++)
                                  DataColumn2(
                                     label: Center(child: Text(conditionhdrlist[i].toString(), style: TextStyle(fontWeight: FontWeight.bold),)),
                                  ),
                                ],
                                 rows: List<DataRow>.generate(_conditionModel.data!.conditionLibrary!.length, (index) => DataRow(cells: 
                                   [
                                    for(int i = 0; i < conditionhdrlist.length; i++)
                                      if(conditionhdrlist[i] == 'Enable')
                                         DataCell( MySwitch(
                        value: _conditionModel.data!.conditionLibrary![index].enable ?? false,
                        onChanged: ((value) {
                          setState(() {
                           // Listofvalue?[index].value = !value ? '0' : '1';
                           _conditionModel.data!.conditionLibrary![index].enable = value;
                           print(value);

                          });
                          // Listofvalue?[index].value = value;
                        }),
                      ),) 
                      else if(conditionhdrlist[i] == 'Notification')
                                         DataCell( MySwitch(
                        value: _conditionModel.data!.conditionLibrary![index].notification ?? false,
                        onChanged: ((value) {
                          setState(() {
                           // Listofvalue?[index].value = !value ? '0' : '1';
                           _conditionModel.data!.conditionLibrary![index].notification = value;
                           print(value);

                          });
                          // Listofvalue?[index].value = value;
                        }),
                      ),) 
                                      else if(conditionhdrlist[i] == 'Duration')  
                                          DataCell(Center(child: InkWell(child:  Text(
            '${_conditionModel.data!.conditionLibrary![index].duration}',
            style: TextStyle(fontSize: 20),
          ),onTap: () {
                                                _selectTime(context);
                                            },)))
                                      else if(conditionhdrlist[i] == 'Unit Hour')  
                                            DataCell(Center(child: InkWell(child:  Text(
             '${_conditionModel.data!.conditionLibrary![index].untilTime}',
            style: TextStyle(fontSize: 20),
          ),onTap: () {
                                                _selectTime(context);
                                            },)))
                                      else if(conditionhdrlist[i] == 'From Hour')  
                                            DataCell(Center(child: InkWell(child:  Text(
            '${_conditionModel.data!.conditionLibrary![index].fromTime}',
            style: TextStyle(fontSize: 20),
           ),onTap: () {
                                                _selectTime(context);
                                            },)))
                                         else if(conditionhdrlist[i] == 'ID')  
                                           DataCell(Center(child: Text('${_conditionModel.data!.conditionLibrary![index].id}',)))  
                                         else if(conditionhdrlist[i] == 'Name')  
                                           DataCell(Center(child: Text('${_conditionModel.data!.conditionLibrary![index].name}',)))      
                                         else if(conditionhdrlist[i] == 'Contion with')  
                                           DataCell(Center(child: Text('${_conditionModel.data!.conditionLibrary![index].conditionIsTrueWhen}',)))  
                                         else if(conditionhdrlist[i] == 'State')  
                                           DataCell(Center(child: Text('${_conditionModel.data!.conditionLibrary![index].state}',)))      
                                         else if(conditionhdrlist[i] == 'Used Program')  
                                           DataCell(Center(child: Text('${_conditionModel.data!.conditionLibrary![index].usedByProgram}',)))      
   
                                      else
                                           DataCell(Center(child: Text('data',)))
                                  ]
              )))
                ),
            ),
          Flexible(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(children: [
                Container(height: 40,width: double.infinity,color: Colors.amber,child: Center(child: Text('Used Program',)),),
                DropdownButton(
                            items: usedprogramdropdownlist.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(items)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                usedprogramdropdownstr = value.toString();
                              });
                            },
                            value: usedprogramdropdownstr == '' ? usedprogramdropdownlist[0].toString() : usedprogramdropdownstr,
                                
                          ),
                             DropdownButton(
                            items: usedprogramdropdownlist2.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(items)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                usedprogramdropdownstr2 = value.toString();
                              });
                            },
                            value: usedprogramdropdownstr2 == '' ? usedprogramdropdownlist2[0].toString() : usedprogramdropdownstr2,
                                
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: TextField(showCursor: true,decoration: InputDecoration(hintText: 'Enter values'),)),
                          )
              
               ],),
              
            ),
          )),
          ],
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
    );
  }

  Widget buildTab(List<dynamic> usernamedata, int t) {
    List<String> heading = ['id', 'location', 'name'];
    int titlecountcheck = 3;
    int itemcount = usernamedata.length;

    if (usernamedata[0]['location'] == "") {
      titlecountcheck = 2;
      heading = ['id', 'name'];
    }

    return Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'ID',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              titlecountcheck == 3
                  ? Expanded(
                      child: Container(
                        child: TextFormField(
                          readOnly: true,
                          initialValue: 'Location',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: 'Name',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Expanded(
                              child: Container(),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
