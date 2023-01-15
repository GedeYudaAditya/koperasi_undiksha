import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/models/user_model.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/services/user_services.dart';

class Tarikan extends StatefulWidget {
  Tarikan({Key? key}) : super(key: key);

  @override
  State<Tarikan> createState() => _TarikanState();
}

class _TarikanState extends State<Tarikan> {
  UserReferences pref = UserReferences();

  UserServices userServices = UserServices();

  List<UserModel?> user = [];

  String? userId;

  UserModel? myUser;

  final _nominalController = TextEditingController();

  void getUser() async {
    userId = await pref.getUserId();
    user = await userServices.getUser(userId: userId!);
    setState(() {
      myUser = user[0];
    });
  }

  void tarikSaldo(nominal) async {
    userId = await pref.getUserId();
    await userServices.tarikan(nominal: nominal, userId: userId!).then((value) {
      // snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Penarikan berhasil'),
          backgroundColor: Colors.green,
        ),
      );
    }).onError((error, stackTrace) {
      // snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Penarikan gagal'),
          backgroundColor: Colors.red,
        ),
      );
    });

    user = await userServices.getUser(userId: userId!);
    setState(() {
      myUser = user[0];
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(10),
          //   ),
          // ),
          // leading: Container(
          //   margin: const EdgeInsets.only(left: 10),
          //   child: Image.asset('assets/images/logo.png'),
          // ),
          backgroundColor: Color.fromARGB(255, 103, 2, 255),
          title: const Text('Penarikan Saldo'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (myUser != null) {
              return Container(
                // padding: const EdgeInsets.only(
                //         top: 55,
                //       ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
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
                    const SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.indigo),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(82, 0, 0, 0),
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nominalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Jumlah Penarikan',
                              hintText: 'Masukkan Jumlah Penarikan',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_nominalController.text.isNotEmpty) {
                                tarikSaldo(_nominalController.text);
                                _nominalController.clear();
                              }
                            },
                            child: const Text('Tarik'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // History
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.indigo),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(82, 0, 0, 0),
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        shrinkWrap: true,
                        children: const [
                          ListTile(
                            title: Text('Penarikan'),
                            subtitle: Text('Rp. 100.000'),
                            trailing: Text('20-10-2021'),
                          ),
                          ListTile(
                            title: Text('Penarikan'),
                            subtitle: Text('Rp. 100.000'),
                            trailing: Text('20-10-2021'),
                          ),
                        ],
                      ),
                    ),
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
