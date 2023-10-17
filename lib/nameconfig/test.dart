import 'package:flutter/material.dart';

class MyAppTest extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Container(
            //     height: 200,
            //     width: double.infinity,
            //     child: Text('Selected Values: ${selectedValues.join(", ")}')),
            // SizedBox(height: 10),
            ListView.builder(
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
                            scrollDirection: Axis
                                .horizontal, // Or use vertical based on your requirement
                            itemCount: 10, // Inner list item count
                            itemBuilder: (context, innerIndex) {
                              bool isSelected =
                                  selectedValues.contains('index $innerIndex');
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedValues
                                          .remove('index $innerIndex');
                                    } else {
                                      selectedValues.add('index $innerIndex');
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  margin: EdgeInsets.all(4),
                                  child: Center(
                                    child: CircleAvatar(
                                      backgroundColor: isSelected
                                          ? Colors.amber
                                          : Colors.white,
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
          ],
        ),
      ),
    );
  }
}
