 import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/groupdetails.dart';

class MyAppTest extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {
  List<String> selectedValuesList = [];
  List<String> orderedSelectedValues = [];
  List<String> groupValues = [];
  int selectedgroupIndex = -1;
  String selectgroup = '';
  int selectline = -1;
  List<List<dynamic>> myGroup = [
    ['group 1', false]
  ];

  List<String> grouplist = [];
  List<String> emptygrouplist = [];

  int oldgroupIndex = -1;
  int oldindex = -1;
  Map<String, List<Map<String, dynamic>>> jsondata = {
    "group": [
      {
        "srno": 1,
        "id": 1,
        "name": "Group1",
        "location": "Line 1",
        "value": ["1", "2", "4"]
      },
      {
        "srno": 2,
        "id": 2,
        "name": "Group2",
        "location": "Line 2",
        "value": ["1", "2", "4"]
      },
      {
        "srno": 3,
        "id": 3,
        "name": "Group3",
        "location": "Line 3",
        "value": ["1", "2", "3", "4"]
      },
      {
        "srno": 4,
        "id": 4,
        "location": "Line 4",
        "name": "Group4",
        "value": ["1", "2", "3", "4"]
      },
      {"srno": 5, "id": 5, "location": "Line 4", "name": "Group5", "value": []},
      {"srno": 6, "id": 6, "location": "Line 4", "name": "Group6", "value": []}
    ],
    "line": [
      {
        "srno": 1,
        "id": 1,
        "name": "Line 1",
        "value": ["1", "2", "3", "4"]
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

    valueAssign();
    selectvalvelistvalue();
  }

  void valueAssign() {
    setState(() {
      selectedgroupIndex = jsondata['group']!.isNotEmpty ? 0 : -1;
      emptygrouplist.clear();
      grouplist.clear();
      for (var i = 0; i < jsondata['group']!.length; i++) {
        if (jsondata['group']![i]['value'].length > 0) {
          grouplist.add('${jsondata['group']![i]['name']}');
        } else {
          emptygrouplist.add('${jsondata['group']![i]['name']}');
        }
      }
      print(emptygrouplist);
    });
  }

  void selectvalvelistvalue() {
    setState(() {
      if (selectedgroupIndex != -1) {
        selectedValuesList = [];
        selectline = int.parse(jsondata['group']![selectedgroupIndex]['location'].split(' ')[1]);
        print(jsondata['group']![selectedgroupIndex]['value']);
        print(selectedgroupIndex);

        for (var i in jsondata['group']![selectedgroupIndex]['value']) {
          // selectedValuesList.add(i.split('.')[1]);
          selectedValuesList.add(i);
        }
      }
    });
  }

  Map<String, dynamic> colorchange() {
    return {'line': jsondata['group']![selectedgroupIndex]['location'].split(' ')[1], 'valve': jsondata['group']![selectedgroupIndex]['value']};
  }

  void _showDetailsScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DetailsSection(
          data: jsondata['group']!,
          onClose: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showAlertDialog(
    BuildContext context,
    String title,
    String msg,
    bool btncount,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            btncount
                ? TextButton(
                    child: Text("cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
            title: Text(
          'Groups',
          textAlign: TextAlign.center,
        )),
        body: Padding(
          padding: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: 80.0, right: 80.0, top: 10.0, bottom: 20.0) : EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text(
                  '$selectgroup ${selectedValuesList.join(",")}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Groups'),
                    trailing: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        jsondata['group']!.isNotEmpty ? _showDetailsScreen(context) : AboutDialog();
                      },
                    ),
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
                            itemCount: grouplist.length,
                            itemBuilder: (context, groupIndex) {
                              String gname = jsondata['group']![groupIndex]['name'].toString();

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print(grouplist);
                                    print(selectedgroupIndex);
                                    print(groupIndex);

                                    selectedgroupIndex = groupIndex;
                                    selectvalvelistvalue();
                                  });
                                },
                                child: Container(
                                  // width: 0,
                                  margin: EdgeInsets.all(4),
                                  child: Center(
                                      child: Chip(
                                    label: Text(gname),
                                    backgroundColor: selectedgroupIndex == groupIndex ? Colors.amber : Colors.blueGrey,
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(2),
                      child: FloatingActionButton(
                        elevation: 4,
                        onPressed: () {
                          setState(() {
                            print('emptygrouplist-----------$emptygrouplist');
                            if (emptygrouplist.isNotEmpty) {
                              grouplist.add(emptygrouplist[0].toString());
                              emptygrouplist.removeAt(0);
                              print('grouplist.........$grouplist');
                              print('emptygrouplist-----------$emptygrouplist');
                            } else {
                              print('show alert');
                              _showAlertDialog(context, 'Warning', 'Group Limit is Reached', false);
                            }
                            // valueAssign();
                          });

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
                                  itemCount: (jsondata['line']![index]['value']?.length) ?? 0,
                                  itemBuilder: (context, innerIndex) {
                                    String vname = jsondata['line']![index]['value'][innerIndex].toString();

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print('selectline----$selectline-----index---${index + 1}');

                                          if (selectline != (index + 1)) {
                                            orderedSelectedValues.clear();
                                            selectedValuesList.clear();
                                            selectline = index + 1;
                                          }
                                          print('selectline----$selectline-----index---${index + 1}');
                                          if (selectedValuesList.contains('$vname')) {
                                            selectedValuesList.remove('$vname');
                                            orderedSelectedValues.remove('$vname');
                                          } else {
                                            selectedValuesList.add('$vname');
                                            orderedSelectedValues.add('$vname');
                                          }
                                          selectline = index + 1;

                                          print(selectedValuesList);
                                        });
                                      },
                                      child: Container(
                                        width: 70,
                                        margin: EdgeInsets.all(4),
                                        child: Center(
                                          child: CircleAvatar(
                                            backgroundColor: selectline == index + 1 && selectedValuesList.contains(vname) ? Colors.amber : Colors.blueGrey,
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
        floatingActionButton: Row(
          children: [
            Spacer(),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.delete),
            ),
            SizedBox(
              width: 5,
            ),
            FloatingActionButton(
              onPressed: () {
                jsondata['group']?[selectedgroupIndex]['value'] = selectedValuesList;
                jsondata['group']?[selectedgroupIndex]['location'] = 'Line $selectline';
                print(jsondata);
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
        // ),
      );
    });
  }
}







import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final VoidCallback onClose;

  DetailsSection({required this.data, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            constraints: BoxConstraints.expand(),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 300,
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    Text(
                      'Group Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: onClose,
                      color: Colors.red,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Group',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Line',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Valve',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: List.generate(data.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(data[index]['name'].toString())),
                          DataCell(Text(data[index]['location'].toString())),
                          DataCell(Text(data[index]['value'].toString())),
                        ]);
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
