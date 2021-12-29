import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/orders.dart' show Orders;
import '/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Finish your order first, by clicking the on delivery button, or use the bottom nav if provided'),
          duration: Duration(seconds: 3),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(
            order: orderData.orders[i],
          ),
          itemCount: orderData.orders.length,
        ),
      ),
    );
  }
}
