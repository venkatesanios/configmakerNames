import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/myapp.dart';
import 'package:nameconfig/nameconfig/groupscreen.dart';
import 'package:nameconfig/nameconfig/test.dart';
import 'package:nameconfig/service/call.dart';
import 'package:nameconfig/nameconfig/name_config_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowMaterialGrid: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: MyAppTest(),
      ),
    );
  }
}
