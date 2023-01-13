import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key}) : super(key: key);

  double hitungPersentase(double total, double persentase) {
    return total * persentase / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: hitungPersentase(MediaQuery.of(context).size.height, 2),
      ),
      padding: const EdgeInsets.all(10),
      color: Colors.teal[100],
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
            size: 80,
            color: const Color.fromARGB(255, 65, 33, 243),
          ),
        ],
      ),
    );
  }
}
