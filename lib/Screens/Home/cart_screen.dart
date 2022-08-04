import 'package:ebutler/Screens/Home/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/Shared/constants.dart';
import '/providers/cart.dart' show Cart;
//show buat ngasi tau cm butuh Cart class
import '/widgets/cart_item.dart';
import '/Services/database.dart';
import '/Model/arguments.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final argument = Arguments();
    final cart = Provider.of<Cart>(context);

    Future<bool> alert() async {
      return await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('You cannot edit your order if you proceed'),
          actions: <Widget>[
            //kalo pencet "NO"
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text(
                'No',
                style: TextStyle(color: kYellowColor),
              ),
            ),
            //kalo pencet "YES"
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
                DatabaseService().setUserData();

                Navigator.of(context).pushNamed(PaymentScreen.routeName,
                    arguments: Arguments(
                      roomNumberData: argument.roomNumberData,
                    ));
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: kYellowColor),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(color: kYellowColor),
        ),
        leading: BackButton(
          color: kYellowColor,
        ),
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
                      argument.roomNumberData = val;
                    },
                    validator: (val) => val.isEmpty ||
                            int.parse(val) < 200 ||
                            int.parse(val) > 399 && int.parse(val) < 600 ||
                            int.parse(val) > 1199
                        ? 'Please enter room number, and the room number cannot exceed 1199 or less than 200'
                        : null,
                    //Room Numbernya ga boleh < 200 / > 1199
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
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                          backgroundColor: kWhiteColor,
                        ),
                        ElevatedButton(
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                                color: kYellowColor,
                                backgroundColor: kPrimaryColor),
                          ),
                          onPressed: cart.itemCount < 1 ||
                                  cart.totalQuantity > 6
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'You cannot order more than six items or no items at all',
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              : () {
                                  if (_formKey.currentState.validate()) {
                                    alert();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please input the room number correctly',
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                  _formKey.currentState.reset();
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
