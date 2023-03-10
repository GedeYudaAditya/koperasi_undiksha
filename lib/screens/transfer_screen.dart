import 'dart:math';

import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/models/user_model.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/services/notif_services.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
import 'package:push_notification/push_notification.dart';

class Transfer extends StatefulWidget {
  Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  // get arguments qr
  String? qrData;

  UserReferences pref = UserReferences();

  UserServices userServices = UserServices();

  List<UserModel?> user = [];

  String? userId;

  UserModel? myUser;

  int? biayaAdmin;

  late Notificator notification;

  String notificationKey = 'key';
  String _bodyText = 'notification test';

  final _nominalController = TextEditingController();
  final _nomorRekeningController = TextEditingController();
  final _pinController = TextEditingController();

  // notif firebase
  NotifService notifService = NotifService();

  void getUser() async {
    userId = await pref.getUserId();
    user = await userServices.getUser(userId: userId!);
    setState(() {
      myUser = user[0];
      biayaAdmin = int.parse(myUser!.nomorRekening.substring(1));
    });
  }

  void transferSaldo(String nominal, rekening, password) async {
    List<UserModel?> users = await userServices.getAllUser();
    bool isExist = false;
    for (var i = 0; i < users.length; i++) {
      if (users[i]!.nomorRekening == rekening) {
        isExist = true;
        break;
      }
    }
    userId = await pref.getUserId();

    String? token = await notifService.getTokenFromFirebaseFirestore(rekening);

    if (isExist) {
      // check password
      if (myUser!.password == password) {
        // check saldo

        // biaya admin adalah 4 digit nomor rekening terakhir akun yang melakukan transfer
        // rekening memiliki total 5 digit
        if (myUser!.saldo >= (int.parse(nominal) + biayaAdmin!)) {
          await userServices
              .transfer(
                  nominal: nominal, userId: userId!, rekeningTujuan: rekening)
              .then((value) {
            // snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transfer berhasil'),
                backgroundColor: Colors.green,
              ),
            );

            // Local notification
            notification.show(
              Random().nextInt(100),
              'Transfer berhasil',
              'Transfer sebesar $nominal berhasil',
              imageUrl: 'https://www.lumico.io/wp-019/09/flutter.jpg',
              data: {notificationKey: '[notification data]'},
              notificationSpecifics: NotificationSpecifics(
                AndroidNotificationSpecifics(
                  autoCancelable: true,
                ),
              ),
            );

            // Firebase notification
            notifService.sendPushNotification(
                title: 'Saldo Telah Masuk!',
                body: 'Saldo sebesar $nominal telah masuk ke akun anda',
                token: token!);
            
          }).onError((error, stackTrace) {
            // snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transfer gagal'),
                backgroundColor: Colors.red,
              ),
            );
          });

          await userServices.tarikan(
              nominal: biayaAdmin.toString(), userId: userId!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Saldo tidak cukup'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN/Password salah'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor rekening tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
    }

    user = await userServices.getUser(userId: userId!);
    setState(() {
      myUser = user[0];
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
    notification = Notificator(
      onPermissionDecline: () {
        // ignore: avoid_print
        print('permission decline');
      },
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText = 'notification open: '
                '${notificationData[notificationKey].toString()}';
          },
        );
      },
    )..requestPermissions(
        requestSoundPermission: true,
        requestAlertPermission: true,
      );
  }

  @override
  Widget build(BuildContext context) {
    qrData = ModalRoute.of(context)!.settings.arguments as String?;

    if (qrData != null) {
      _nomorRekeningController.text = qrData!;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 103, 2, 255),
          title: const Text('Transfer Saldo'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (myUser != null) {
              return Container(
                // padding: const EdgeInsets.only(
                //   top: 65,
                // ),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            'Saldo Anda',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Rp. ${myUser!.saldo}',
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                        // margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        color: const Color.fromARGB(188, 27, 145, 255),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // History trasfer circular shape
                            Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  '30230',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  '30230',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  '30230',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    // Form transfer
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              'Transfer Saldo',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              'Masukkan nominal saldo yang akan ditransfer',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Saat transfer anda akan dikenakan biaya admin sebesar Rp. $biayaAdmin',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _nominalController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan nominal',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _nomorRekeningController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan nomor rekening',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _pinController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan PIN / Password',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          // Button
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                transferSaldo(
                                    _nominalController.text,
                                    _nomorRekeningController.text,
                                    _pinController.text);
                              },
                              child: const Text('Transfer'),
                            ),
                          ),
                        ]))
                  ]),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
