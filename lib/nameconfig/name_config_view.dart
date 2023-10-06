import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/name_config_model.dart';
import 'package:nameconfig/service/http_services.dart';

class NameConfigWidget extends StatefulWidget {
  const NameConfigWidget({super.key});

  @override
  State<NameConfigWidget> createState() => _NameConfigWidgetState();
}

class _NameConfigWidgetState extends State<NameConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          // Render mobile content
          return Nameconfig();
        } else {
          // Render web content
          return Nameconfig();
        }
      },
    );
  }
}

class Nameconfig extends StatefulWidget {
  const Nameconfig({super.key});

  @override
  State<Nameconfig> createState() => _NameconfigState();
}

class _NameconfigState extends State<Nameconfig> {
  ///Users/user/Desktop/flutter/configmakerNames/lib/nameconfig/api.json
  List<String> headinglist = [];

  NamesModel data = NamesModel();
  List<Datum>? namesdata;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Map<String, Object> body = {"userId": '1', "controllerId": '1'};
    final response = await HttpService().postRequest("getUserName", body);
    final jsonData = json.decode(response);

    try {
      setState(() {
        data = NamesModel.fromJson(jsonData);
        // print(data.toJson());
        namesdata = data.data!;
        print(namesdata?.length);

        for (var i = 0; i < data.data!.length; i++) {
          headinglist.add(jsonData['data'][i]['nameDescription'].toString());
        }
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: headinglist.length,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Names Config Maker'),
            backgroundColor: const Color.fromARGB(255, 158, 208, 233),
            bottom: TabBar(
              indicatorColor: Color.fromARGB(255, 175, 73, 73),
              isScrollable: true,
              tabs: [
                for (int i = 0; i < namesdata!.length; i++)
                  Tab(
                    text: namesdata?[i].nameDescription.toString() ?? '',
                    // icon: Icon(Icons.ac_unit),
                  ),
              ],
            ),
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   color: Color.fromARGB(255, 181, 244, 237),
            //  ),
            child: TabBarView(
              children: [
                for (int i = 0; i < namesdata!.length; i++)
                  buildTab(['ID', 'Location', 'Name'],
                      headinglist[i].toString(), i + 1),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Send',
            child: Icon(Icons.send),
          ),
        ),
      ),
    );
  }

  Widget buildTab(List<String> heading, String name, int itemcount) {
    String namechech = '';
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
                    readOnly: true,
                    initialValue: heading[i].toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        )),
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
                                    heading[i].toString(), index + 1, name),
                                textAlign: TextAlign.center,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                      ],
                    )),
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
    print(headingtype);
    print(i);
    if (headingtype == 'ID') {
      return '$i';
      print(name);
    } else if (headingtype == 'Location') {
      print(headingtype);
      return 'Line$i';
    } else {
      print(headingtype);
      return '$name$i';
    }
  }
}
