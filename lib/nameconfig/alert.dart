import 'package:flutter/material.dart';

class MyAppalert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showDetails = false;

  List<Map<String, String>> data = [
    {'group': 'Group 1', 'line': 'Line 1', 'valve': 'Valve 1'},
    {'group': 'Group 2', 'line': 'Line 2', 'valve': 'Valve 2'},
    {'group': 'Group 3', 'line': 'Line 3', 'valve': 'Valve 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: _showDetails
            ? DetailsSection(
                data: data,
                onClose: () {
                  setState(() {
                    _showDetails = false;
                  });
                },
              )
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showDetails = true;
                  });
                },
                child: Text('Go to Details'),
              ),
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  final List<Map<String, String>> data;
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
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: onClose,
                    ),
                  ],
                ),
                DataTable(
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
                      DataCell(Text(data[index]['group'].toString())),
                      DataCell(Text(data[index]['line'].toString())),
                      DataCell(Text(data[index]['valve'].toString())),
                    ]);
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
