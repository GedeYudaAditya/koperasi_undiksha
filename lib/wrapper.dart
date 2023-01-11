import 'package:flutter/material.dart';
import 'package:koperasi_undiksha/references/user_references.dart';
import 'package:koperasi_undiksha/screens/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  UserReferences userReferences = UserReferences();

  String? userId;

  @override
  void initState() {
    super.initState();
    // cek jika terdapat data login
    userReferences.getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // cek jika terdapat data login
    setState(() {
      userReferences.getUserId().then((value) {
        userId = value;
      });
    });

    print('userId: $userId');

    if (userId != null && userId != '') {
      // jika ada, maka arahkan ke halaman home
      return Container(
        child: const Text('Home'),
      );
    } else {
      // jika tidak ada, maka arahkan ke halaman login
      return const LoginScreen();
    }
  }
}
