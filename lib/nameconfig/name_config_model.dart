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
  final List<String> headinglist = [
    'Water Source',
    'Water Pump',
    'Irrigation Line',
    'Valve Default',
    'Irrigation Valve',
    'Main Valve',
    'Dosing Site',
    'Filtration Site',
    'Fertilizer',
    'Dosing Meter',
    'Fertilizer Set',
    'Filter',
    'Interface',
    'Program',
    'Satellite',
    'Analog Sensor',
    'Contact',
    'Pressure Sensor',
    'Differential Pressure Sensor',
    'Valve Group',
    'Water Meter',
    'Alarm',
    'Condition',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: headinglist.length,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Names Config'),
            backgroundColor: const Color.fromARGB(255, 158, 208, 233),
            bottom: TabBar(
              indicatorColor: Color.fromARGB(255, 175, 73, 73),
              isScrollable: true,
              tabs: [
                for (int i = 0; i < headinglist.length; i++)
                  Tab(
                    text: headinglist[i].toString(),
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
                for (int i = 0; i < headinglist.length; i++)
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
                        // decoration: BoxDecoration(
                        //     border: Border.all(), color: Colors.amber),
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
                                onChanged: (value) {
                                  // print(value);
                                },
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
