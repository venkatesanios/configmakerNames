import 'package:flutter/material.dart';

class MyAppalert  {
  
   

  void _showAlertDialog(
    BuildContext context,
    String title,
    String msg,
    bool btncount,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            btncount
                ? TextButton(
                    child: const Text("cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        );
      },
    );
  }

}

 