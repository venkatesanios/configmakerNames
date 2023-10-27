import 'dart:convert';

import 'package:flutter/material.dart';
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
          return const ConditionUI();
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
  int tabclickindex = 0;

  List<String> Conditionlist = [
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
    List<String> Conditionhdrlist = [
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
  String usedprogramdropdownstr = '';
List<String> usedprogramdropdownlist = ['Program Starting',
'Program Ending','Program is Running','Program is Not Running','Contact is opened','Contact is closed','Contact is opening','Contact is closing'];
    String usedprogramdropdownstr2 = '';
List<String> usedprogramdropdownlist2 = ['Program Starting',
'Program Ending','Program is Running','Program is Not Running','Contact is opened','Contact is closed','Contact is opening','Contact is closing'];
 

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
      length: Conditionlist.length,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Conditions Library'),
            backgroundColor: Color.fromARGB(255, 31, 164, 231),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: Colors.deepOrange,
                    indicatorColor: const Color.fromARGB(255, 175, 73, 73),
                    isScrollable: true,
                    
                    // controller: _tabController,
                    tabs: [
                      for (var i = 0; i < Conditionlist.length; i++)
                        Tab(
                          text: Conditionlist[i].toString(),
                        ),
                    ],
                    onTap: (value) {
                      setState(() {
                        tabclickindex = value;
                      });
                      
                    },
                  ),
                ),
 Expanded(
  child:
  Container(margin: EdgeInsets.all(30),
   child: SingleChildScrollView(
     child: Column(children: [
     ListTile(title: Text(Conditionhdrlist[0]),trailing: Text('Conditions ${tabclickindex+1}'),tileColor: Colors.lightBlue[400],),
     ListTile(title: Text(Conditionhdrlist[1]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[2]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[3]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[4]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[5]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[6]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[7]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[8]),trailing: Text('data'),),
     ListTile(title: Text(Conditionhdrlist[9]),trailing: Text('data'),),
     ]),
   ),
 ),
 )
              ],
            ),
          ),
          // child: TabBarView(
          //   // controller: _tabController,
          //   children: [
          //     for (int i = 0; i < jsondata.length; i++)
          //       jsondata[i]['userName'].length == 0
          //           ? Container()
          //           : buildTab(jsondata[i]['userName'], i),
          //   ],
          // ),
          // ),
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
