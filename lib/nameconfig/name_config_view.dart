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
  List<dynamic> headinglist = [];
  List<String> usernamelist = [];
  NamesModel data = NamesModel();
  dynamic jsondata;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Map<String, Object> body = {"userId": '1', "controllerId": '1'};
    final response = await HttpService()
        .postRequest("getUserName", body); // await the HTTP request
    final jsonData = json.decode(response);
    jsondata = jsonData;
    for (var i = 0; i < jsondata['data'].length; i++) {
      setState(() {
        headinglist.add(jsonData['data'][i]['nameDescription']);
        usernamelist.add(jsonData['data'][i]['userName']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: headinglist.length,
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
                for (int i = 0; i < headinglist.length; i++)
                  Tab(
                    text: headinglist[i].toString(),
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
                for (int i = 0; i < headinglist.length; i++)
                  usernamelist[i] == ""
                      ? Container()
                      : buildTab(
                          ['ID', 'Location', 'Name'],
                          usernamelist[i],
                        ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (jsondata != null) {
                print('jsondata-----------------send---------$jsondata');
              } else {
                print('jsondata is null');
              }
            },
            tooltip: 'Send',
            child: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }

  Widget buildTab(
    List<String> heading,
    String usernamedata,
  ) {
    dynamic json = usernamedata != "" ? jsonDecode(usernamedata) : {};
    int titlecountcheck = 3;
    int itemcount = json['data'].length;
    String namechech = '';
    if (json['data'][0]['location'] == "") {
      titlecountcheck = 2;
    }

    return Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Center(child: Text('ID'))),
              titlecountcheck == 3
                  ? Expanded(child: Text('Location'))
                  : Container(),
              Expanded(child: Center(child: Text('Name'))),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: ListView.builder(
              itemCount: itemcount,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < heading.length; i++)
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  readOnly: heading[i].toString() == 'Name'
                                      ? false
                                      : true,
                                  initialValue: Namechech(
                                      heading[i].toString(), index + 1, 'Name'),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {},
                                ),
                              ),
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

  String Namechech(String headingtype, int i, String name) {
    if (headingtype == 'ID') {
      return '$i';
    } else if (headingtype == 'Location') {
      return 'Line$i';
    } else {
      return '$name$i';
    }
  }
}
