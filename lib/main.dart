import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/screens/register_screen.dart';
import 'package:koperasi_undiksha/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(),
      routes: {
        '/login': (context) => Wrapper(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
