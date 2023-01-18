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
                Navigator.pushNamed(context, '/login');
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tarik');
              },
              icon: const Icon(Icons.credit_card),
            ),
          ],
        ),
      ),
    );
  }
}
