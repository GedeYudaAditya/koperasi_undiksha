import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/models/user_model.dart';

import '../references/user_references.dart';
import '../services/user_services.dart';
import 'grid_view_widget.dart';

import 'package:qr_flutter/qr_flutter.dart';

class BerandaWidget extends StatefulWidget {
  BerandaWidget({Key? key, this.myUser}) : super(key: key);

  UserModel? myUser;

  @override
  State<BerandaWidget> createState() => _BerandaWidgetState();
}

class _BerandaWidgetState extends State<BerandaWidget> {
  // Fungsi untuk menghitung hasil nilai dari persentase sebuah total nilai
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text('Saldo Anda',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center),

          Text('Rp. ${user!.saldo}',
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          // Tombol Refresh
          ElevatedButton(
            onPressed: () async {
              await updateUser();
              setState(() {
                user = user;
                user!.saldo = user!.saldo;
              });
            },
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              // horizontal: MediaQuery.of(context).size.width * 0.025,
              horizontal:
                  hitungPersentase(MediaQuery.of(context).size.width, 3),
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.indigo),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(110, 0, 0, 0),
                  blurRadius: 10,
                  offset: Offset(5, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width:
                      hitungPersentase(MediaQuery.of(context).size.width, 25),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(20),
                  //   image: const DecorationImage(
                  //     // Pakai data dari model
                  //     image: NetworkImage(
                  //         'https://reqres.in/img/faces/3-image.jpg'),
                  //   ),
                  // ),
                  child: QrImage(
                    data: user!.nomorRekening,
                    version: QrVersions.auto,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      // height: 50,
                      width: hitungPersentase(
                          MediaQuery.of(context).size.width, 60),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 178, 186, 223),
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
                            // Pakai data dari model
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
                      width: hitungPersentase(
                          MediaQuery.of(context).size.width, 60),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 178, 186, 223),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nomor Rekening',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user!.nomorRekening,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            // height: hitungPersentase(MediaQuery.of(context).size.height, 20),
            margin: EdgeInsets.symmetric(
              horizontal:
                  hitungPersentase(MediaQuery.of(context).size.width, 3),
            ),
            // padding:
            //     const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.indigo),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(110, 0, 0, 0),
                  blurRadius: 10,
                  offset: Offset(5, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: GridViewWidget(id: user!.userId),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: hitungPersentase(MediaQuery.of(context).size.height, 5),
            ),
            padding: const EdgeInsets.all(10),
            color: Color.fromARGB(255, 178, 186, 223),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Butuh Bantuan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('0878-1234-1024',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                const Icon(
                  Icons.phone,
                  size: 100,
                  color: Color.fromARGB(255, 65, 33, 243),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
