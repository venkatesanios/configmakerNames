import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDropDown extends StatefulWidget {
  String? initialValue;
  String? purpose;
  List<String> itemList;
  final Function(String value)? setValue;

  MyDropDown({
    super.key,
    this.initialValue,
    required this.itemList,
    this.purpose,
    this.setValue,
  });

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 245, 245),
          //borderRadius: BorderRadius.circular(10),
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 2,
          ))),
      child: DropdownButton(
        underline: Container(),
        // Initial Value
        value: widget.initialValue ?? widget.itemList[0],
        isExpanded: true,
        // Down Arrow Icon
        icon: Padding(
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
        // Array list of items
        items: widget.itemList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Container(
                padding: EdgeInsets.only(left: 10), child: Text(items)),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          // if (widget.purpose == 'addProduct/model') {
          //   addProductPvd.editModel(newValue!);
          // } else if (widget.purpose == 'addProduct/category') {
          //   addProductPvd.editcategory(newValue!);
          // } else if (widget.purpose == 'addProduct/Status') {
          //   addProductPvd.editProductstatus(newValue!);
          // } else {}
          // widget.setValue!(newValue ?? '-/-');
          widget.initialValue = newValue!;
        },
      ),
    );
  }
}
