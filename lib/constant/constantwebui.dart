import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:nameconfig/const/custom_switch.dart';
import 'package:nameconfig/service/http_services.dart';
import 'package:data_table_2/data_table_2.dart';


class ConstantwebUI extends StatefulWidget {
  const ConstantwebUI({Key? key});

  @override
  State<ConstantwebUI> createState() => _ConstantWebUIState();
}

class _ConstantWebUIState extends State<ConstantwebUI> with TickerProviderStateMixin {
  dynamic jsondata;

  List<String> constantlist = [
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
    List<String> constanthdrlist = [
    'ID',
    'Name',
    'Enable',
    'State',
    'Duration',
    'Contion with ',
    'From Hour',
    'Unit Hour',
    'Notification',
    'Used Program',
  ];

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  Future<void> fetchData() async {
    Map<String, Object> body = {"userId": '1', "controllerId": '1'};
    final response = await HttpService().postRequest("getgroups", body);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      setState(() {
        final jsondata1 = jsonDecode(response.body);
        jsondata = jsondata1['data'];
        print('--jsondata--------$jsondata');
      });
    } else {
      //_showSnackBar(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: constantlist.length,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Conditions'),
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
                                                              for(int i = 0; i < constanthdrlist.length;i++)
                                                                  
                                                              DataColumn2(
                                                                  label: Text(constanthdrlist[i], style: TextStyle(fontWeight: FontWeight.bold),),
                                                               ),
                                                            ],
                                                            rows: List<DataRow>.generate(50, (index) => DataRow(cells: 
                                                            [
                                                              for(int i = 0; i < constanthdrlist.length; i++)
                                                                if(constanthdrlist[i] == 'Enable')
                                                                   DataCell(MySwitch(onChanged: (value) {
                                                                     
                                                                   },
                                                                   value: false,
                                                                   )) 
                                                                else if(constanthdrlist[i] == 'Duration')  
                                                                    DataCell(Text('data'))
                                                                else if(constanthdrlist[i] == 'Unit Hour')  
                                                                    DataCell(Text('data'))
                                                                else if(constanthdrlist[i] == 'From Hour')  
                                                                    DataCell(Text('data')) 
                                                                else
                                                                    DataCell(Text('data'))
                                                            ]
                                                            )))
                  ),
              ),
            Flexible(child: Container()),
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
