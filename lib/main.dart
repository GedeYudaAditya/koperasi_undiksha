import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/screens/register_screen.dart';
import 'package:koperasi_undiksha/screens/storan_screen.dart';
import 'package:koperasi_undiksha/screens/tarik_screen.dart';
import 'package:koperasi_undiksha/screens/transfer_screen.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
import 'package:koperasi_undiksha/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(600, name: 'Midle'),
            ResponsiveBreakpoint.resize(700, name: 'MidleLarge'),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScaleDown(900, name: 'LargeTablet'),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserServices(),
        child: Wrapper(),
      ),
      routes: {
        '/login': (context) => Wrapper(),
        '/register': (context) => RegisterScreen(),
        '/setor': (context) => Setoran(),
        '/tarik': (context) => Tarikan(),
        '/transfer': (context) => Transfer(),
      },
    );
  }
}
