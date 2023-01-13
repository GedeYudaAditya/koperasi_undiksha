import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/beranda_widget.dart';
import 'components/beranda_widget_desktop.dart';
import 'components/bottom_bar_widget_beranda.dart';
import 'components/contact_wiget.dart';
import 'models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String _scanBarcode = 'Unknown';
  final _formKey = GlobalKey<FormState>();

  UserReferences userReferences = UserReferences();
  UserServices userServices = UserServices();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _services = UserServices();

  String? userId;

  List<UserModel?> _mod = [null];

  // bool toggle = false;

  void awaiting() async {
    await userReferences.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // awaiting();

  // }
  void datas(userId) async {
    if (_mod[0] == null) {
      _mod = await userServices.getUser(userId: userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // cek jika terdapat data login
    userReferences.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });

    // print('userId: $userId');

    if (userId != null && userId != '') {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile banking Undiksha'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  userId = null;
                  _mod = [null];
                  userReferences.setNullAllData();
                });
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: FutureBuilder(
          builder: ((context, snapshot) {
            datas(userId);

            if (_mod[0] != null) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: BerandaWidgetDesktop(myUser: _mod[0]),
                            ),
                          ),
                          const Expanded(
                            flex: 3,
                            child: ContactWidget(),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: BerandaWidget(myUser: _mod[0]),
                      ),
                    );
                  }
                },
              );

              // return Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Selamat datang, ${_mod[0]!.nama}'),
              //       Text('Rekening: ${_mod[0]!.nomorRekening}'),
              //       Text('Email: ${_mod[0]!.username}'),
              //     ],
              //   ),
              // );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
        bottomNavigationBar: const BottomBarWidgetBeranda(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () => scanQR(),
          tooltip: 'Transfer',
          child: const Icon(Icons.qr_code_scanner),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    } else {
      // jika tidak ada, maka arahkan ke halaman login
      return Scaffold(
        appBar: AppBar(
          title: const Text('Login Koperasi Undiksha'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png', width: 200),
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
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        // key: _formKey,
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            gapPadding: 2.0,
                          ),
                          hintText: 'Yuda Aditya',
                        ),
                      ),
                      const Divider(),
                      TextFormField(
                        // key: _formKey,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          hintText: '********',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Login menggunakan services

                          await _services
                              .loginUser(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          )
                              .then((value) {
                            if (value != [null]) {
                              // print(value);
                              setState(() {
                                userReferences.setUserId(value[0]!.userId);
                                userId = value[0]!.userId;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Anda berhasil login'),
                                ),
                              );
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, '/login', (route) => false,
                              //     arguments: value);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Username atau Password salah'),
                                ),
                              );
                            }
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Username atau Password salah'),
                              ),
                            );
                          });
                        },
                        child: const SizedBox(
                          width: 100,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text('Daftar Mbanking'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('lupa password?'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // print(barcodeScanRes);

      // open barcodeScanRes to browser

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      final Uri url = Uri.parse(_scanBarcode);
      _launchUrl(url);
    });
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
