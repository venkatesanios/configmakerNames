import 'package:flutter/material.dart';

class MyApp12 extends StatelessWidget {
  void _showDataTableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200, // Adjust the height as needed
          child: Column(
            children: [
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Group',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Valves',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Group 1')),
                      DataCell(Text('Valve 1')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Group 2')),
                      DataCell(Text('Valve 2')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Group 3')),
                      DataCell(Text('Valve 3')),
                    ],
                  ),
                  // Add more DataRow widgets for more rows
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Table in Bottom Sheet'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => _showDataTableBottomSheet(context),
            child: Text('Open Bottom Sheet'),
          ),
        ),
      ),
    );
  }
}
