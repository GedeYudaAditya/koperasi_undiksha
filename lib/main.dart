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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // firebase initialize app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getToken();
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

void getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
    // FirebaseMessaging.instance.onTokenRefresh
    // .listen((fcmToken) {
    //   // TODO: If necessary send token to application server.

    //   // Note: This callback is fired at each app startup and whenever a new
    //   // token is generated.
    // })
    // .onError((err) {
    //   // Error getting token.
    // });

    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
}