import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/name_config_model.dart';
import 'package:nameconfig/service/http_services.dart';

class NameConfigWidget extends StatefulWidget {
  const NameConfigWidget({Key? key});

  @override
  State<NameConfigWidget> createState() => _NameConfigWidgetState();
}

class _NameConfigWidgetState extends State<NameConfigWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          // Render mobile content
          return const Nameconfig();
        } else {
          // Render web content
          return const Nameconfig();
        }
      },
    );
  }
}

class Nameconfig extends StatefulWidget {
  const Nameconfig({Key? key});

  @override
  State<Nameconfig> createState() => _NameconfigState();
}

class _NameconfigState extends State<Nameconfig> with TickerProviderStateMixin {
  dynamic jsondata;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Map<String, Object> body = {"userId": '1', "controllerId": '1'};
    final response = await HttpService().postRequest("getUserName", body);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      setState(() {
        final jsondata1 = jsonDecode(response.body);
        jsondata = jsondata1['data'];
      });
    } else {
      //_showSnackBar(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: jsondata.length,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Names Config Maker'),
            backgroundColor: const Color.fromARGB(255, 158, 208, 233),
            bottom: TabBar(
              indicatorColor: const Color.fromARGB(255, 175, 73, 73),
              isScrollable: true,
              // controller: _tabController,
              tabs: [
                for (var i = 0; i < jsondata.length; i++)
                  Tab(
                    text: jsondata[i]['nameDescription'].toString(),
                  ),
              ],
              onTap: (value) {
                print(value);
              },
            ),
          ),
          body: Container(
            child: TabBarView(
              // controller: _tabController,
              children: [
                for (int i = 0; i < jsondata.length; i++)
                  jsondata[i]['userName'].length == 0
                      ? Container()
                      : buildTab(jsondata[i]['userName'], i),
              ],
            ),
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
