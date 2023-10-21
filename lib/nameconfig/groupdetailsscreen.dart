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
            color: Colors.transparent,
            constraints: BoxConstraints.expand(),
          ),
        ),
        Center(
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.8,
            // height: 300,
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
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      onPressed: onClose,
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
