import 'package:flutter/material.dart';

class MyApp3 extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fixed Header DataTable'),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columnSpacing: 30,
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 100, // Adjust the width as needed
                        child: Text('Column 1'),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 100, // Adjust the width as needed
                        child: Text('Column 2'),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 100, // Adjust the width as needed
                        child: Text('Column 3'),
                      ),
                    ),
                    // Add more DataColumn widgets as needed
                  ],
                  rows: List<DataRow>.generate(
                    20,
                    (index) => DataRow(cells: [
                      DataCell(Text('Row $index, Cell 1')),
                      DataCell(Text('Row $index, Cell 2')),
                      DataCell(Text('Row $index, Cell 3')),
                      // Add more DataCell widgets as needed
                    ]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      // Your data rows here
                      // ...
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
