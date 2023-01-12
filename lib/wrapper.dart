import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/screens/login_screen.dart';
import 'package:koperasi_undiksha/services/user_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  UserReferences userReferences = UserReferences();
  UserServices userServices = UserServices();

  String? userId;

  // bool toggle = false;

  void awaiting() async {
    await userReferences.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    awaiting();
  }

  @override
  Widget build(BuildContext context) {
    // cek jika terdapat data login
    userReferences.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });

    print('userId: $userId');

    if (userId != null) {
      // jika ada, maka arahkan ke halaman home
      return Scaffold(
        body: Container(
          child: const Text('Home'),
        ),
      );
    } else {
      // jika tidak ada, maka arahkan ke halaman login
      return Scaffold(
        body: LoginScreen(),
      );
    }
  }
}
