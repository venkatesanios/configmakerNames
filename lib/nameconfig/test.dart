import 'package:flutter/material.dart';

class MyAppTest extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {
  List<List<String>> selectedValuesList = List.generate(5, (index) => []);
  List<String> orderedSelectedValues = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selected Valves: ${orderedSelectedValues.join(",")}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Outer list item count
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Line $index'),
                          SizedBox(height: 10),
                          Container(
                            height: 100, // Set the height of the inner list
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10, // Inner list item count
                              itemBuilder: (context, innerIndex) {
                                bool isSelected = selectedValuesList[index]
                                    .contains('$index.$innerIndex');
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedValuesList[index]
                                            .remove('$index.$innerIndex');
                                        orderedSelectedValues
                                            .remove('$index.$innerIndex');
                                      } else {
                                        selectedValuesList[index]
                                            .add('$index.$innerIndex');
                                        orderedSelectedValues
                                            .add('$index.$innerIndex');
                                      }
                                      for (int i = 0;
                                          i < selectedValuesList.length;
                                          i++) {
                                        if (i != index) {
                                          selectedValuesList[i].clear();
                                          // orderedSelectedValues.clear();
                                        }
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
                                        child: Text('A'),
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
        ),
      ),
    );
  }
}
