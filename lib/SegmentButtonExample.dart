import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentButtonExample extends StatefulWidget {
  @override
  _SegmentButtonExampleState createState() => _SegmentButtonExampleState();
}

class _SegmentButtonExampleState extends State<SegmentButtonExample> {
  int _currentSelection = 0;

  final Map<int, Widget> _children = {
    0: Text('First'),
    1: Text('Second'),
    2: Text('Third'),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Segmented Button Example'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSegmentedControl<int>(
              children: _children,
              onValueChanged: (value) {
                setState(() {
                  _currentSelection = value;
                });
              },
              groupValue: _currentSelection,
            ),
            SizedBox(height: 20),
            Text(
              'Selected: ${_children[_currentSelection]}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
