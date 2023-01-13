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
      padding: const EdgeInsets.all(5),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.account_balance_wallet,
                size: 50,
                color: Color.fromARGB(255, 65, 33, 243),
              ),
              ResponsiveVisibility(
                hiddenWhen: [
                  Condition.smallerThan(name: DESKTOP),
                ],
                visibleWhen: [
                  Condition.smallerThan(name: 'Midle'),
                ],
                child: Text(
                  "Cek Saldo",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 33, 243),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ListUserPage()));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.money,
                  size: 50,
                  color: Color.fromARGB(255, 65, 33, 243),
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
            Navigator.pushNamed(context, '/tarik', arguments: widget.id);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.attach_money,
                  size: 50,
                  color: Color.fromARGB(255, 65, 33, 243),
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
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.credit_card,
                size: 50,
                color: Color.fromARGB(255, 65, 33, 243),
              ),
              ResponsiveVisibility(
                hiddenWhen: [
                  Condition.smallerThan(name: DESKTOP),
                ],
                visibleWhen: [
                  Condition.smallerThan(name: 'Midle'),
                ],
                child: Text(
                  "Pembayaran",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 33, 243),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.monitor_weight,
                size: 50,
                color: Color.fromARGB(255, 65, 33, 243),
              ),
              ResponsiveVisibility(
                hiddenWhen: [
                  Condition.smallerThan(name: DESKTOP),
                ],
                visibleWhen: [
                  Condition.smallerThan(name: 'Midle'),
                ],
                child: Text(
                  "Peminjaman",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 33, 243),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.account_balance,
                size: 50,
                color: Color.fromARGB(255, 65, 33, 243),
              ),
              ResponsiveVisibility(
                hiddenWhen: [
                  Condition.smallerThan(name: DESKTOP),
                ],
                visibleWhen: [
                  Condition.smallerThan(name: 'Midle'),
                ],
                child: Text(
                  "Cek Mutasi",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 33, 243),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
