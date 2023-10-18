import 'package:flutter/material.dart';

class MyAppTest1 extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest1> {
  int selectedGroupIndex = -1;
  List<String> orderedSelectedValues = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selected Value: ${orderedSelectedValues.isNotEmpty ? orderedSelectedValues[0] : ""}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100, // Set the height of the inner list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Number of groups
                itemBuilder: (context, groupIndex) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGroupIndex = groupIndex;
                        orderedSelectedValues.clear();
                        orderedSelectedValues.add("Group $groupIndex");
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.all(4),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: selectedGroupIndex == groupIndex
                              ? Colors.amber
                              : Colors.blueGrey,
                          child: Text('A'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: selectedGroupIndex != -1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Lines in Group $selectedGroupIndex',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 100, // Set the height of the inner list
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                5, // Number of lines in the selected group
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Line $index'),
                                      SizedBox(height: 10),
                                      Container(
                                        height:
                                            100, // Set the height of the inner list
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              10, // Inner list item count
                                          itemBuilder: (context, innerIndex) {
                                            bool isSelected =
                                                selectedGroupIndex == index;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (selectedGroupIndex ==
                                                      index) {
                                                    selectedGroupIndex = -1;
                                                    orderedSelectedValues
                                                        .clear();
                                                  } else {
                                                    selectedGroupIndex = index;
                                                    orderedSelectedValues
                                                        .clear();
                                                    orderedSelectedValues
                                                        .add("Line $index");
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 100,
                                                margin: EdgeInsets.all(4),
                                                child: Center(
                                                  child: CircleAvatar(
                                                    backgroundColor: isSelected
                                                        ? Colors.amber
                                                        : Colors.blueGrey,
                                                    child: Text(
                                                        '${innerIndex + 1}'),
                                                  ),
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
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(), // If no group is selected, show an empty container
            ),
          ],
        ),
      ),
    );
  }
}
