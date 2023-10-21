import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/name_model.dart';
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
  List<NamesModelnew> _namesList = <NamesModelnew>[];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await HttpService()
        .postRequest("getUserName", {"userId": '8', "controllerId": '1'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _namesList = List.from(data["data"])
          .map((item) => NamesModelnew.fromJson(item))
          .toList();
      setState(() {});
    } else {
      // _showSnackBar(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _namesList != null ? _namesList.length : 0,
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
                for (var i = 0; i < _namesList.length; i++)
                  Tab(
                    // text: _namesList[i]['nameDescription'].toString(),
                    text: _namesList[i].nameDescription,
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
                for (int i = 0; i < _namesList.length; i++)
                  _namesList[i].userName!.isEmpty
                      ? Container()
                      : buildTab(_namesList[i].userName!, i),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              List<Map<String, dynamic>> nameListJson =
                  _namesList.map((name) => name.toJson()).toList();

              Map<String, dynamic> body = {
                "userId": '8',
                "controllerId": "1",
                "userNameList": nameListJson,
                "createUser": "1"
              };
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
                                  readOnly: heading[i].toString() == 'name'
                                      ? false
                                      : true,
                                  initialValue: usernamedata[index][heading[i]],
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      usernamedata[index]['name'] = value;
                                    });
                                  },
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
}
