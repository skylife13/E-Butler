import 'package:ebutler/Screens/Home/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/Shared/constants.dart';
import '/providers/cart.dart' show Cart;
//show buat ngasi tau cm butuh Cart class
import '/widgets/cart_item.dart';
import '/Services/database.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String roomNumberData;
    final cart = Provider.of<Cart>(context);

    Future<bool> alert() async {
      return await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('You cannot edit your order if you proceed'),
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
                DatabaseService().setUserData();

                Navigator.of(context).pushNamed(PaymentScreen.routeName,
                    arguments: roomNumberData);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     PaymentScreen.routeName, (route) => false,
                //     arguments: roomNumberData);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Room Number'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val) {
                      roomNumberData = val;
                    },
                    validator: (val) => val.isEmpty
                        ? 'Ga guna... gr gr bkn stateful, eman eman tapi kalo jadi stateful, ttp butuh bwt snackbar'
                        : null,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Spacer(),
                        Chip(
                          label: Text(
                            'Rp. ${cart.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        TextButton(
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: cart.itemCount > 0
                              ? () {
                                  if (_formKey.currentState.validate()) {
                                    alert();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please Enter Room Number',
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                  _formKey.currentState.reset();
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please Add an Item First',
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                  productId: cart.items.keys.toList()[i],
                  id: cart.items.values.toList()[i].id,
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
