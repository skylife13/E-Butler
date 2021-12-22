import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/Shared/constants.dart';
import '/providers/cart.dart' show Cart;
//show buat ngasi tau cm butuh Cart class
import '/widgets/cart_item.dart';
import '/providers/orders.dart';
import 'order_screen.dart';
import '/Services/database.dart';
import '/Model/user.dart';
import '/Services/history.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String roomNumberData;
    final cart = Provider.of<Cart>(context);

    final user = Provider.of<User>(context);
    void updatedb() {
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
                        ? 'Ga guna... gr gr bkn stateful, eman eman tapi kalo jadi stateful'
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
                                    DatabaseService().setUserData();
                                    updatedb();
                                    Provider.of<Orders>(context, listen: false)
                                        .addOrder(
                                      cart.items.values.toList(),
                                      cart.totalAmount,
                                    );
                                    cart.clear();

                                    Navigator.of(context)
                                        .pushNamed(OrderScreen.routeName);
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
