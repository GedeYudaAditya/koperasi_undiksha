import 'package:flutter/material.dart';

class BottomBarWidgetBeranda extends StatefulWidget {
  const BottomBarWidgetBeranda({Key? key}) : super(key: key);

  @override
  State<BottomBarWidgetBeranda> createState() => _BottomBarWidgetBerandaState();
}

class _BottomBarWidgetBerandaState extends State<BottomBarWidgetBeranda> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 134, 150, 218),
      shape: const CircularNotchedRectangle(),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
              icon: const Icon(Icons.settings),
            ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/transfer');
            //   },
            //   icon: const Icon(Icons.qr_code_scanner),
            // ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/riwayat');
            //   },
            //   icon: const Icon(Icons.history),
            // ),
            IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ListUserPage()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
