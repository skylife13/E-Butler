import 'package:ebutler/Screens/Home/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart.dart';
import '/Services/history.dart';
import '/Services/database.dart';
import '/Model/user.dart';
import '/providers/orders.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}) : super(key: key);

  static const routeName = '/paymentscreen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);
    final roomNumberData = ModalRoute.of(context).settings.arguments as String;
    String total = cart.totalAmount.toString();
    void updatedb() {
      // History().setHistory();
      DatabaseService().setUserData();
      for (int i = 0; i < cart.itemCount; i++) {
        DatabaseService(uid: user.uid).updateUserCart(
            int.parse(roomNumberData),
            i,
            cart.items.keys.toList()[i],
            cart.totalAmount,
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].price *
                cart.items.values.toList()[i].quantity,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity);

        History(uid: user.uid).setHistory(
            i,
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].quantity,
            cart.items.values.toList()[i].price,
            int.parse(roomNumberData),
            cart.items.keys.toList()[i],
            cart.totalAmount,
            cart.items.values.toList()[i].price *
                cart.items.values.toList()[i].quantity);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'You cannot go back, press Cancel Purchase button if you want to cancel your purchase'),
          duration: Duration(seconds: 3),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            children: [
              const Text(
                'Payment',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Total Payment: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Please transfer to: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'xxx xxx xxxx',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Admin Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(
                      cart.items.values.toList(),
                      cart.totalAmount,
                    );
                    updatedb();
                    cart.clear();
                    Navigator.of(context).pushNamed(OrderScreen.routeName);
                  },
                  child: const Text('I have Completed Payment'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Your order data will be cleared'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                              cart.clear();
                              Navigator.of(context).pushNamed('/');
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    'Cancel Purchase',
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Guide',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '1. Go to Mobile BCA application ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '2. Go to m-Transfer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '3. Go to Daftar Transfer section and press Antar Rekening if you have not registered the admin name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '4. Enter xxx xxx xxxx then press send',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '5. Go to transfer section, then choose the account which you want to transfer your money',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Text(
                  '6. Enter the amount correctly then send',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
