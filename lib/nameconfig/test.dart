import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/const/drop_down_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SourcePumpTable extends StatefulWidget {
  const SourcePumpTable({super.key});

  @override
  State<SourcePumpTable> createState() => _SourcePumpTableState();
}

class _SourcePumpTableState extends State<SourcePumpTable> {
  ScrollController scrollController = ScrollController();
  bool selectButton = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      var width = constraint.maxWidth;
      return Container(
        margin: (MediaQuery.of(context).orientation == Orientation.portrait ||
                kIsWeb)
            ? null
            : EdgeInsets.only(right: 70),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [Text('Select')],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //configPvd.sourcePumpFunctionality(['editsourcePumpSelection',false]);
                          //configPvd.cancelSelection();
                        },
                        icon: Icon(Icons.cancel_outlined)),
                    // Text('${configPvd.selection}')
                  ],
                ),
                IconButton(
                  color: Colors.yellow,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  highlightColor: Colors.blue,
                  onPressed: () {
                    // configPvd.sourcePumpFunctionality(['addSourcePump']);
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(
                          milliseconds: 500), // Adjust the duration as needed
                      curve: Curves.easeInOut, // Adjust the curve as needed
                    );
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  splashColor: Colors.grey,
                  color: Colors.yellow,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  highlightColor: Colors.blue,
                  onPressed: () {},
                  icon: Icon(Icons.batch_prediction),
                ),
                IconButton(
                  color: Colors.yellow,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  highlightColor: Colors.blue,
                  onPressed: () {
                    // configPvd.sourcePumpFunctionality(['deleteSourcePump']);
                    // configPvd.cancelSelection();
                  },
                  icon: Icon(Icons.delete_forever),
                ),
                Row(
                  children: [
                    // Checkbox(
                    //     // value: configPvd.sourcePumpSelectAll,
                    //     onChanged: (value){
                    //       setState(() {
                    //         configPvd.sourcePumpFunctionality(['editsourcePumpSelectAll',value]);
                    //       });
                    //     }
                    // ),
                    Text('All')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: width - 20,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Source',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('Pump({configPvd.totalSourcePump})',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Water',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('Source(6)',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Water',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('Meter({configPvd.totalWaterMeter})',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          index == 1 - 1 ? EdgeInsets.only(bottom: 60) : null,
                      color: index % 2 != 0
                          ? Colors.blue.shade100
                          : Colors.blue.shade50,
                      width: width - 20,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                width: double.infinity,
                                height: 60,
                                child: MyDropDown(
                                  initialValue: '1',
                                  itemList: ['1', '2', '3'],
                                )),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 60,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
