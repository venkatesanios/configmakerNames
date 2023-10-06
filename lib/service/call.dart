import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Call Example'),
        ),
        body: Center(
          child: CallButton(), // Use the CallButton widget
        ),
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _makePhoneCall(String phoneNumber) async {
      final url = 'tel:$phoneNumber';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    return IconButton(
      icon: Icon(Icons.phone),
      onPressed: () {
        _makePhoneCall('9123590805');
      },
    );
  }
}
