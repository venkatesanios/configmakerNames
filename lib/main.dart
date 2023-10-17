import 'package:flutter/material.dart';
import 'package:nameconfig/nameconfig/test.dart';
import 'package:nameconfig/service/call.dart';
import 'package:nameconfig/nameconfig/name_config_view.dart';

void main() {
  runApp(MyAppTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const NameConfigWidget(),
      ),
    );
  }
}
