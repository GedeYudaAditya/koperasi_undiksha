import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/screens/register_screen.dart';
import 'package:koperasi_undiksha/screens/storan_screen.dart';
import 'package:koperasi_undiksha/screens/tarik_screen.dart';
import 'package:koperasi_undiksha/screens/transfer_screen.dart';
import 'package:koperasi_undiksha/services/notif_services.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
import 'package:koperasi_undiksha/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  await setupInteractedMessage();
}

// void requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print('User granted provisional permission');
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }

// It is assumed that all messages contain a data field with the key 'type'
Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

_launchURL() async {
  if (!await launchUrl(
    Uri.parse(
        'https://www.google.com/'), //url ini bisa kalian ganti dengan url lain
    mode: LaunchMode.externalApplication,
  )) {
    throw "Tidak bisa membuka halaman";
  }
}

void _handleMessage(RemoteMessage message) {
  if (message.notification!.title == 'pesan berhasil') {
    _launchURL();
  }
}

void main() async {
  // firebase initialize app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotifService notifService = NotifService();

  notifService.requestPermission();
  runApp(const MyApp());
}

// void saveToken() async {
//   await FirebaseMessaging.instance.getToken().then((token) {
//     UserReferences ref = UserReferences(); 

//     print('token: $token');

//     ref.setTokenMessaging(token!);
//   });
// }

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
