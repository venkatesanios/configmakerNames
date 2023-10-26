import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/constant/constantwebui.dart';
import 'package:nameconfig/service/http_services.dart';

class ConstantScreenWidget extends StatefulWidget {
  const ConstantScreenWidget({Key? key});

  @override
  State<ConstantScreenWidget> createState() => _ConstantScreenWidgetState();
}

class _ConstantScreenWidgetState extends State<ConstantScreenWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          // Render mobile content
          return const ConstantUI();
        } else {
          // Render web content
          return  ConstantwebUI();
        }
      },
    );
  }
}

class ConstantUI extends StatefulWidget {
  const ConstantUI({Key? key});

  @override
  State<ConstantUI> createState() => _ConstantUIState();
}

class _ConstantUIState extends State<ConstantUI> with TickerProviderStateMixin {
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
            title: const Text('Constants'),
            backgroundColor: Color.fromARGB(255, 31, 164, 231),
          ),
          body: Container(
            child: TabBar(
              labelColor: Colors.deepOrange,
              indicatorColor: const Color.fromARGB(255, 175, 73, 73),
              isScrollable: true,
              // controller: _tabController,
              tabs: [
                for (var i = 0; i < constantlist.length; i++)
                  Tab(
                    text: constantlist[i].toString(),
                  ),
              ],
              onTap: (value) {
                print(value);
              },
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
