import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'grid_view_widget.dart';

class BerandaWidgetDesktop extends StatefulWidget {
  BerandaWidgetDesktop({Key? key, this.myUser}) : super(key: key);

  UserModel? myUser;

  @override
  State<BerandaWidgetDesktop> createState() => _BerandaWidgetDesktopState();
}

class _BerandaWidgetDesktopState extends State<BerandaWidgetDesktop> {
  double hitungPersentase(double total, double persentase) {
    return total * persentase / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: hitungPersentase(MediaQuery.of(context).size.width, 3),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(
                // horizontal: MediaQuery.of(context).size.width * 0.025,
                vertical:
                    hitungPersentase(MediaQuery.of(context).size.width, 3),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 200,
                      width: hitungPersentase(
                          MediaQuery.of(context).size.width, 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://reqres.in/img/faces/${widget.myUser!.userId}-image.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(10),
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
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
                                widget.myUser!.nama,
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
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Saldo Anda',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp.${widget.myUser!.saldo}',
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
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // height: hitungPersentase(MediaQuery.of(context).size.height, 48),
              // padding: const EdgeInsets.only(
              //     left: 10, right: 10, top: 10, bottom: 10),
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
              child: GridViewWidget(id: widget.myUser!.userId),
            ),
          ),
        ],
      ),
    );
  }
}
