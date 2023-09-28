import 'package:flutter/material.dart';

class NameConfigv extends StatelessWidget {
  const NameConfigv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NameConfig();
  }
}

class NameConfig extends StatelessWidget {
  const NameConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Name Config'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Water Source'),
              Tab(text: 'Water Pump'),
              Tab(text: 'Line'),
              Tab(text: 'Valve'),
              Tab(text: 'Interface'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Different content for each tab
            buildTab(),
            buildWaterPumpTab(),
            buildLineTab(),
            buildValveTab(),
            buildInterfaceTab(),
          ],
        ),
      ),
    );
  }

  Widget buildWaterSourceTab() {
    // Implement the content for the 'Water Source' tab here
    return Text('Water Source Tab Content');
  }

  Widget buildWaterPumpTab() {
    // Implement the content for the 'Water Pump' tab here
    return Text('Water Pump Tab Content');
  }

  Widget buildLineTab() {
    // Implement the content for the 'Line' tab here
    return Text('Line Tab Content');
  }

  Widget buildValveTab() {
    // Implement the content for the 'Valve' tab here
    return Text('Valve Tab Content');
  }

  Widget buildInterfaceTab() {
    // Implement the content for the 'Interface' tab here
    return Text('Interface Tab Content');
  }

  Widget buildTab() {
    final List<TextEditingController> nameControllers =
        List.generate(5, (_) => TextEditingController());

    return Expanded(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ID'),
                Text('Name'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Column(
                    children: [
                      index == 0
                          ? Divider(
                              height: 1.0,
                              color: Colors.grey,
                            )
                          : Container(),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: nameControllers[index],
                                  onChanged: (text) {},
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: nameControllers[index],
                                  onChanged: (text) {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
