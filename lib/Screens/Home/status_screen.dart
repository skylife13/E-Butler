import 'package:ebutler/Model/arguments.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/cart.dart' show Cart;
import 'package:ebutler/providers/orders.dart' show Orders;
import 'package:ebutler/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '/Model/user.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);
  static const routeName = '/status';
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final user = Provider.of<User>(context);
    final cart = Provider.of<Cart>(context);
    String uid = user.uid;
    final argument = ModalRoute.of(context).settings.arguments as Arguments;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Please wait until your order has come to your room, then you can use the finish order button that will appear',
              style: TextStyle(fontSize: 18),
            ),
            duration: Duration(seconds: 5),
          ));
          return false;
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Your Room Number: ' + argument.roomNumberData,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: const Text(
                'Robot will appear from the Service Lift',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            if (int.parse(argument.roomNumberData) > 199 &&
                int.parse(argument.roomNumberData) < 300)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: const AssetImage('assets/2nd_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 299 &&
                int.parse(argument.roomNumberData) < 400)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: const AssetImage('assets/3rd_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 599 &&
                int.parse(argument.roomNumberData) < 700)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: AssetImage('assets/6th_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 699 &&
                int.parse(argument.roomNumberData) < 800)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: const AssetImage('assets/7th_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 799 &&
                int.parse(argument.roomNumberData) < 900)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: AssetImage('assets/8th_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 999 &&
                int.parse(argument.roomNumberData) < 1100)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: const AssetImage('assets/10th_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (int.parse(argument.roomNumberData) > 1099 &&
                int.parse(argument.roomNumberData) < 1200)
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                    image: const AssetImage('assets/11th_floor.png'),
                    fit: BoxFit.fill),
              ),
            if (argument.scheduleData == null)
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Status')
                    .doc(uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
                  if (!snapshotStatus.hasData) {
                    return Container(
                      child: const Text('kosong'),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: 175,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (ctx, i) => OrderItem(
                                  order: orderData.orders[i],
                                ),
                                itemCount: orderData.itemCount,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (snapshotStatus.data != null)
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            snapshotStatus.data['Status'] ?? 'no',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      if (snapshotStatus.data['Status'] == 'Order is finished')
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
                            FirebaseFirestore.instance
                                .collection('Status')
                                .doc(uid)
                                .delete();
                            cart.clear();
                            orderData.clear();
                          },
                          child: const Text(
                            'Go to Home',
                            style: TextStyle(
                                color: kYellowColor,
                                backgroundColor: kPrimaryColor),
                          ),
                        ),
                    ],
                  );
                },
              ),
            if (argument.scheduleData != null)
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Scheduled Status')
                    .doc(uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
                  if (!snapshotStatus.hasData) {
                    return Container(
                      child: const Text('kosong'),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: 175,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (ctx, i) => OrderItem(
                                  order: orderData.orders[i],
                                ),
                                itemCount: orderData.itemCount,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (snapshotStatus.data != null)
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                snapshotStatus.data['Status'] ?? 'No',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');

                          cart.clear();
                          orderData.clear();
                        },
                        child: const Text('Go to Home'),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
