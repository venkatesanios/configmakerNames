import "package:flutter/material.dart";

class DetailsSection extends StatelessWidget {
  Map<String, List<Map<String, dynamic>>> data;
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
                      DataCell(Text(data['group']![index]['name'].toString())),
                      DataCell(
                          Text(data['group']![index]['location'].toString())),
                      DataCell(Text(data['group']![index]['value'].toString())),
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
