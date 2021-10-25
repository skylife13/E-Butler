import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/cart.dart' show Cart;
//show buat ngasi tau cm butuh Cart class
import '/widgets/cart_item.dart';
import '/providers/orders.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final cart = Provider.of<Cart>(context);

    return StreamBuilder<UserData>(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
              ),
              body: Column(
                children: <Widget>[
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
                            child: Text('Order Now',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                )),
                            onPressed: () async {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                userData.name,
                                cart.items.values ?? userData.cola,
                                cart.items.values ?? userData.pillow,
                                cart.items.values ?? userData.towel,
                                cart.items.values ?? userData.mineralwater,
                              );
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                cart.items.values.toList(),
                                cart.totalAmount,
                              );
                              cart.clear();
                              Navigator.of(context)
                                  .pushNamed(OrderScreen.routeName);
                            },
                          )
                        ],
                      ),
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
                  ))
                ],
              ),
            );
          } else {
            return null;
          }
        });
  }
}
