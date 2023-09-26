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
      child: Scaffold(
        appBar: AppBar(
          title: Text('Name Config'),
          bottom: const TabBar(
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
    );
  }

  Widget buildTab() {
    return Column(
      children: [
        Flexible(
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ID'),
              Text('Name'),
            ],
          )),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index == 0
                      ? Divider(
                          height: 1.0,
                          color: Colors.grey,
                        )
                      : Container(),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$index'),
                      Text('S$index'),
                    ],
                  )),
                  const Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
