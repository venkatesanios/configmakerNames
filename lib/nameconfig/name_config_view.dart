import 'dart:js_util';

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Name Config'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Water Source',
                  icon: Icon(Icons.ac_unit),
                ),
                Tab(
                  text: 'Water Pump',
                  icon: Icon(Icons.free_breakfast),
                ),
                Tab(
                  text: 'Line',
                  icon: Icon(Icons.file_download_rounded),
                ),
                Tab(
                  text: 'Valve',
                  icon: Icon(Icons.ac_unit),
                ),
                Tab(
                  text: 'Interface',
                  icon: Icon(Icons.ac_unit),
                ),
                Tab(
                  text: 'Analog Sensor',
                  icon: Icon(Icons.memory),
                ),
                Tab(
                  text: 'Contact',
                  icon: Icon(Icons.abc_sharp),
                ),
                Tab(
                  text: 'Valves Group',
                  icon: Icon(Icons.account_box_rounded),
                ),
                Tab(
                  text: 'Water Meter',
                  icon: Icon(Icons.ac_unit),
                ),
                Tab(
                  text: 'Condition',
                  icon: Icon(Icons.ac_unit),
                ),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              children: [
                buildTab(),
                buildTab(),
                buildTab(),
                Text('Fertilizer'),
                Text('Filter'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab() {
    return Column(
      children: [
        Flexible(
          child: Container(
              decoration: BoxDecoration(
                // border: Border(left: BorderSide(width: 2.0, color: Colors.black)),
                //borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(153, 188, 230, 245),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'ID',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        //borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(153, 188, 230, 245),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Name',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 2.0, color: Colors.black),
                          bottom: BorderSide(width: 2.0, color: Colors.black),
                          right: BorderSide(width: 2.0, color: Colors.black),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 2.0, color: Colors.black),
                                ),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: '$index',
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: 'Source $index ',
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                          ),
                        ],
                      )),
                  // const Divider(
                  //   height: 1.0,
                  //   color: Colors.grey,
                  // ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
