import 'package:ebutler/providers/cart.dart' show Cart;
import 'package:ebutler/providers/orders.dart' show Orders;
import 'package:ebutler/widgets/cart_item.dart';
import 'package:ebutler/widgets/order_item.dart';
import 'package:lottie/lottie.dart';
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
    final roomNumberData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Please wait until your order comes to your room, then you can use the Finish Order button that will appear',
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
                'Your Room Number: $roomNumberData',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Robot will appear from the Service Lift',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            if (int.parse(roomNumberData) > 199 &&
                int.parse(roomNumberData) < 300)
              Image(
                  image: AssetImage('assets/2nd_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 299 &&
                int.parse(roomNumberData) < 400)
              Image(
                  image: AssetImage('assets/3rd_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 599 &&
                int.parse(roomNumberData) < 700)
              Image(
                  image: AssetImage('assets/6th_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 699 &&
                int.parse(roomNumberData) < 800)
              Image(
                  image: AssetImage('assets/7th_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 799 &&
                int.parse(roomNumberData) < 900)
              Image(
                  image: AssetImage('assets/8th_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 999 &&
                int.parse(roomNumberData) < 1100)
              Image(
                  image: AssetImage('assets/10th_floor.png'), fit: BoxFit.fill),
            if (int.parse(roomNumberData) > 1099 &&
                int.parse(roomNumberData) < 1200)
              Image(
                  image: AssetImage('assets/11th_floor.png'), fit: BoxFit.fill),
            StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('Status')
                  .document(uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
                if (!snapshotStatus.hasData) {
                  // Navigator.of(context).pushNamed('/');
                  return Container(
                    child: Text('kosong'),
                  );
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 175,
                      child: Column(
                        children: [
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemBuilder: (ctx, i) => CartItem(
                          //         productId: cart.items.keys.toList()[i],
                          //         id: cart.items.values.toList()[i].id,
                          //         title: cart.items.values.toList()[i].title,
                          //         quantity:
                          //             cart.items.values.toList()[i].quantity,
                          //         price: cart.items.values.toList()[i].price),
                          //     itemCount: cart.itemCount,
                          //   ),
                          // ),
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
                          snapshotStatus.data['Status'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    if (snapshotStatus.data['Status'] == 'Order is finished')
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');
                          Firestore.instance
                              .collection('Status')
                              .document(uid)
                              .delete();
                          cart.clear();
                          orderData.clear();
                        },
                        child: Text('Finish Order'),
                      ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
