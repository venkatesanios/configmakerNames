import 'package:flutter/material.dart';

class MyAppTest2 extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest2> {
  late List<List<String>> selectedValuesList;
  List<String> orderedSelectedValues = [];
  List<String> groupValues = [];
  int selectedgroupIndex = -1;
  String selectgroup = '';

  int oldgroupIndex = -1;
  int oldindex = -1;
  Map<String, List<Map<String, dynamic>>> jsondata = {
    "group": [
      {
        "srno": 1,
        "id": 1,
        "name": "Group1",
        "location": "Line 1",
        "value": ["1.1", "1.2", "1.3", "1.4"]
      },
      {
        "srno": 2,
        "id": 2,
        "name": "Group2",
        "location": "Line 2",
        "value": ["2.1", "2.2", "2.4"]
      },
      {
        "srno": 3,
        "id": 3,
        "name": "Group3",
        "location": "Line 3",
        "value": ["3.1", "3.2", "3.3", "3.4"]
      },
      {
        "srno": 4,
        "id": 4,
        "location": "Line 4",
        "name": "Group4",
        "value": ["4.1", "4.2", "4.3", "4.4"]
      }
    ],
    "line": [
      {
        "srno": 1,
        "id": 1,
        "name": "Line 1",
        "value": ["0", "2", "3", "4"]
      },
      {
        "srno": 2,
        "id": 2,
        "name": "Line 2",
        "value": ["1", "2", "3", "4"]
      },
      {
        "srno": 3,
        "id": 3,
        "name": "Line 3",
        "value": ["2", "5", "3", "4"]
      },
      {
        "srno": 4,
        "id": 4,
        "name": "Line 4",
        "value": ["3", "2", "5", "4"]
      },
      {
        "srno": 5,
        "id": 5,
        "name": "Line 5",
        "value": ["4", "2", "3", "5"]
      }
    ]
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedgroupIndex = jsondata['group']!.isNotEmpty ? 0 : -1;
    // selectedValuesList = selectedgroupIndex != -1
    //     ? List.generate(jsondata['line']!.length,
    //         (index) => jsondata['group']![selectedgroupIndex]['value'])
    //     : List.generate(jsondata['line']!.length, (index) => []);
    selectedValuesList = List.generate(jsondata['line']!.length, (index) => []);
    selectedValuesList[selectedgroupIndex] =
        jsondata['group']![selectedgroupIndex]['value'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
            title: Text(
          'Groups',
          textAlign: TextAlign.center,
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Text(
                '$selectgroup ${orderedSelectedValues.join(",")}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: ListTile(
                  title: Text('Groups'),
                  trailing: Icon(Icons.info),
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 80, // Set the height of the inner list
                      child: Scrollbar(
                        // thumbVisibility: true,
                        trackVisibility: true,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemCount: jsondata['group']?.length,
                          itemBuilder: (context, groupIndex) {
                            bool isGroupSelected =
                                selectedgroupIndex == groupIndex;
                            String gname = jsondata['group']![groupIndex]
                                    ['name']
                                .toString();
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (oldgroupIndex != -1 &&
                                      oldgroupIndex != groupIndex) {
                                    orderedSelectedValues.clear();
                                    for (int i = 0;
                                        i < selectedValuesList.length;
                                        i++) {
                                      if (i != groupIndex) {
                                        selectedValuesList[i].clear();
                                      }
                                    }
                                  }
                                  if (selectedgroupIndex == groupIndex) {
                                    selectedgroupIndex = -1;
                                    orderedSelectedValues.clear();
                                  } else {
                                    selectedgroupIndex = groupIndex;
                                    orderedSelectedValues.clear();
                                    selectgroup = 'Group ${groupIndex + 1}:';
                                  }
                                  oldgroupIndex = groupIndex;
                                  print(
                                      '-----oldgroupIndex------- $oldgroupIndex');
                                });
                              },
                              child: Container(
                                width: 50,
                                margin: EdgeInsets.all(4),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: isGroupSelected
                                        ? Colors.amber
                                        : Colors.blueGrey,
                                    child: Text('G${groupIndex + 1}'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Container(width: 50,height: 100,child: ,),
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(2),
                    child: FloatingActionButton(
                      elevation: 4,
                      onPressed: () {
                        print('click add button');
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: jsondata['line']?.length, // Outer list item count
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                              jsondata['line']![index]['name'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 70, // Set the height of the inner list
                            child: Scrollbar(
                              trackVisibility: true,
                              child: ListView.builder(
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                itemCount: (jsondata['line']![index]['value']
                                        ?.length) ??
                                    0,
                                itemBuilder: (context, innerIndex) {
                                  String vname = jsondata['line']![index]
                                          ['value'][innerIndex]
                                      .toString();
                                  bool isSelected = selectedValuesList[index]
                                      .contains('$index.$vname');
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedgroupIndex != -1) {
                                          if (oldindex != -1 &&
                                              oldindex != index) {
                                            orderedSelectedValues.clear();
                                          }
                                          if (isSelected) {
                                            selectedValuesList[index]
                                                .remove('$index.$vname');
                                            orderedSelectedValues
                                                .remove('$index.$vname');
                                          } else {
                                            selectedValuesList[index]
                                                .add('$index.$vname');
                                            orderedSelectedValues
                                                .add('$index.$vname');
                                          }

                                          for (int i = 0;
                                              i < selectedValuesList.length;
                                              i++) {
                                            if (i != index) {
                                              selectedValuesList[i].clear();
                                            }
                                          }
                                          oldindex = index;
                                        }
                                        print(selectedValuesList);
                                      });
                                    },
                                    child: Container(
                                      width: 70,
                                      margin: EdgeInsets.all(4),
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: isSelected
                                              ? Colors.amber
                                              : Colors.blueGrey,
                                          child: Text('$vname'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
