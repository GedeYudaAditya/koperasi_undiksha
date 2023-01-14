import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GridViewWidget extends StatefulWidget {
  GridViewWidget({Key? key, this.id}) : super(key: key);

  String? id;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      // padding: const EdgeInsets.all(5),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 3,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/transfer');
          },
          child: Container(
            // padding: const EdgeInsets.all(8),
            // color: Colors.teal[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // Rounded icon
                CircleAvatar(
                  backgroundColor: Color.fromARGB(249, 32, 154, 220),
                  child: Icon(
                    Icons.compare_arrows,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                ResponsiveVisibility(
                  hiddenWhen: [
                    Condition.smallerThan(name: DESKTOP),
                  ],
                  visibleWhen: [
                    Condition.smallerThan(name: 'Midle'),
                  ],
                  child: Text(
                    "Transfer",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 33, 243),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/tarik');
          },
          child: Container(
            // padding: const EdgeInsets.all(8),
            // color: Colors.teal[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(249, 32, 154, 220),
                  child: Icon(
                    Icons.card_membership,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                ResponsiveVisibility(
                  hiddenWhen: [
                    Condition.smallerThan(name: DESKTOP),
                  ],
                  visibleWhen: [
                    Condition.smallerThan(name: 'Midle'),
                  ],
                  child: Text(
                    "Tarik",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 33, 243),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/setor');
          },
          child: Container(
            // padding: const EdgeInsets.all(8),
            // color: Colors.teal[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(249, 32, 154, 220),
                  child: Icon(
                    Icons.add_card,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                ResponsiveVisibility(
                  hiddenWhen: [
                    Condition.smallerThan(name: DESKTOP),
                  ],
                  visibleWhen: [
                    Condition.smallerThan(name: 'Midle'),
                  ],
                  child: Text(
                    "Storan",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 33, 243),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
