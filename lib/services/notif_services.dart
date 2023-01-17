import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:koperasi_undiksha/references/user_references.dart';

class NotifService {
  UserReferences sharedPrefs = UserReferences();
  Dio dio = Dio();

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print('token: $value');
      saveToken(value);
    });
  }

  void saveToken(String? token) async {
    sharedPrefs.setTokenMessaging(token!);

    String? noRek = await sharedPrefs.getNomorRekening();

    FirebaseFirestore.instance
        .collection('usersToken')
        .doc(noRek)
        .set({'token': token});
  }

  Future<String?> getTokenFromFirebaseFirestore(noRek) async {
    String? token;
    token = await FirebaseFirestore.instance
        .collection('usersToken')
        .doc(noRek)
        .get()
        .then((value) {
      print('token: ${value['token']}');
      return token = value['token'];
    }).onError((error, stackTrace) {
      print('error: $error');
    });
    return token;
  }

  void sendPushNotification(
      {required String title,
      required String body,
      required String token}) async {
    try {
      await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA9ILY0VE:APA91bEM4tOMKNQP-bGRcCY0MPf-l_O42rqU0XwLKJimsmj5_mBOuoWwMJ-X_x5IlC1-VydP0A1gOxQHAVqDat5xIhjNQFrCLlQOxlK91T1goVO0BXxklneGB6Z1kbynGv8tnTZ9uEWP'
          },
        ),
        data: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'android_channel_id': 'dbkoprasi'
            },
            'to': token,
          },
        ),
      );
    } on DioError catch (error, stacktrace) {
      if (kDebugMode) {
        print('Exception occured: $error stackTrace: $stacktrace');
        throw Exception(error.response);
      }
    }
  }
  // late Notificator notification;

  // int transferNotifId = 1;

  // transferNotif(String title, String body) {
  //   String notificationKey = 'key';
  //   String _bodyText = 'notification test';
  //   notification.show(
  //     transferNotifId,
  //     title,
  //     body,
  //     data: {notificationKey: '[notification data]'},
  //     notificationSpecifics: NotificationSpecifics(AndroidNotificationSpecifics(
  //       autoCancelable: true,
  //     )),
  //   );
  // }

  // notification.show(1, "tes notif", 'ini adalah notif tes',
  //           imageUrl:
  //               "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
  //           data: {notificationKey: '[notification data]'},
  //           notificationSpecifics: NotificationSpecifics(
  //             AndroidNotificationSpecifics(
  //               autoCancelable: true,
  //             ),
  //           ))
  //       : print("notif tidak muncul");
}
