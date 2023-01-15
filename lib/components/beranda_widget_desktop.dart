import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/user_model.dart';
import 'grid_view_widget.dart';

class BerandaWidgetDesktop extends StatefulWidget {
  BerandaWidgetDesktop({Key? key, this.myUser}) : super(key: key);

  UserModel? myUser;

  @override
  State<BerandaWidgetDesktop> createState() => _BerandaWidgetDesktopState();
}

class _BerandaWidgetDesktopState extends State<BerandaWidgetDesktop> {
  double hitungPersentase(double total, double persentase) {
    return total * persentase / 100;
  }

  UserModel? user;

  UserReferences pref = UserReferences();

  UserServices userServices = UserServices();

  updateUser() async {
    List<UserModel?> userA = await userServices.getUser(userId: user!.userId);
    user = userA[0];
    print('updateUser ${user!.saldo}');
  }

  startUser() {
    user = widget.myUser;
    print('startUser ${user!.saldo}');
  }

  @override
  void initState() {
    startUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: hitungPersentase(MediaQuery.of(context).size.width, 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(
                  //   // horizontal: MediaQuery.of(context).size.width * 0.025,
                  //   vertical: hitungPersentase(MediaQuery.of(context).size.width, 3),
                  // ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.indigo),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   image: const DecorationImage(
                        //     image: NetworkImage(
                        //         'https://reqres.in/img/faces/3-image.jpg'),
                        //   ),
                        // ),
                        child: ResponsiveWrapper(
                          maxWidth: 105,
                          child: QrImage(
                            data: user!.nomorRekening,
                            version: QrVersions.auto,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'No.Rek : ${user!.nomorRekening}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: hitungPersentase(MediaQuery.of(context).size.width, 3),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        // height: hitungPersentase(MediaQuery.of(context).size.height, 48),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.indigo),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              // height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nasabah',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    user!.nama,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              // height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Total Saldo Anda',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Rp.${user!.saldo}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () async {
                                        await updateUser();
                                        setState(() {
                                          user = user;
                                          user!.saldo = user!.saldo;
                                        });
                                      },
                                      child: const Icon(Icons.refresh,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topCenter,
              // height: hitungPersentase(MediaQuery.of(context).size.height, 48),
              // padding: const EdgeInsets.only(
              //     left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.indigo),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridViewWidget(id: user!.userId),
            ),
          ],
        ),
      ),
    );
  }
}
