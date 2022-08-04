import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/arguments.dart';
import 'package:ebutler/Screens/Home/status_screen.dart';
import 'package:ebutler/Services/statusdatabase.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/providers/cart.dart';
import '/Services/history.dart';
import '/Services/database.dart';
import '/Model/user.dart';
import '/providers/orders.dart';
import '/Services/scheduled.dart';
import '/Services/scheduledstatus.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key}) : super(key: key);

  static const routeName = '/paymentscreen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _enable = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserModel>(context);
    final argument = ModalRoute.of(context).settings.arguments
        as Arguments; //buat ngambil room number di cart screen sebelumnya, time scheduled ordernya nanti bakal diisi dibawahnya nanti

    String total = cart.totalAmount.toString();
    String timeOrdered;

    //ini fungsi Order Later
    void scheduleddb() {
      String date = DateFormat('dd/MM/yyyy - kk:mm').format(
        argument.scheduleData,
      );
      ScheduledStatus().setStatus;
      ScheduledStatus(uid: user.uid)
          .updateUserStatus(int.parse(argument.roomNumberData), date);
      Scheduled().setUserData();

      for (int i = 0; i < cart.itemCount; i++) {
        Scheduled(uid: user.uid).updateUserCart(
            int.parse(argument.roomNumberData),
            i,
            cart.items.keys.toList()[i],
            cart.totalAmount,
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].price *
                cart.items.values.toList()[i].quantity,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity,
            date);

        History(uid: user.uid).setHistory(
            i,
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].quantity,
            cart.items.values.toList()[i].price,
            int.parse(argument.roomNumberData),
            cart.items.keys.toList()[i],
            cart.totalAmount,
            cart.items.values.toList()[i].price *
                cart.items.values.toList()[i].quantity);
      }
    }

    //ini fungsi Order Now
    void updatedb() {
      StatusDatabase().setStatus;
      StatusDatabase(uid: user.uid)
          .updateUserStatus(int.parse(argument.roomNumberData));
      DatabaseService().setUserData();

      for (int i = 0; i < cart.itemCount; i++) {
        DatabaseService(uid: user.uid).updateUserCart(
            int.parse(argument.roomNumberData),
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
            int.parse(argument.roomNumberData),
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Scheduled Cart')
                .where(FieldPath.documentId, isEqualTo: user.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotScheduled) {
              if (!snapshotScheduled.hasData) {
                return const Center(child: Text('FeelsWeirdMan'));
              }

              //nyimpan waktu order
              String time() {
                snapshotScheduled.data.docs.map((doc) {
                  for (var i in doc.data().values) {
                    timeOrdered = i['Time Ordered'];
                    break;
                  }
                }).toList();
                return timeOrdered;
              }

              //MASUK SINI LANGSUNG
              return Center(
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
                          //button "Order for Later"
                          onPressed: snapshotScheduled.data.docs.length > 0
                              //INI JALAN KALO DATA UDAH ADA di collection "Scheduled Cart"
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          'You can only have one scheduled order.\nPress Yes if you want to cancel the previous scheduled order'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop(false);
                                          },
                                          child: const Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              FirebaseFirestore.instance
                                                  .collection('Scheduled Cart')
                                                  .doc(user.uid)
                                                  .delete();
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'Scheduled Status')
                                                  .doc(user.uid)
                                                  .delete();
                                              snapshotScheduled.data.docs
                                                  .map((doc) {
                                                for (var i
                                                    in doc.data().values) {
                                                  timeOrdered =
                                                      i['Time Ordered'];
                                                  break;
                                                }
                                                FirebaseFirestore.instance
                                                    .collection(user.uid)
                                                    .doc(timeOrdered)
                                                    .delete();
                                              }).toList();
                                              Navigator.of(ctx).pop(true);
                                            });
                                          },
                                          child: const Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              //INI JALAN KALO DATA GAK ADA di collection "Scheduled Cart"
                              : () {
                                  setState(() {
                                    _enable = !_enable;
                                  });
                                  if (_enable == false) {
                                    argument.scheduleData = null;
                                  }
                                },
                          child: _enable
                              ? Text('Cancel Order for later',
                                  style: TextStyle(color: kYellowColor))
                              : Text(
                                  'Order for later',
                                  style: TextStyle(color: kYellowColor),
                                )),
                    ),
                    if (_enable)
                      Column(
                        children: [
                          Container(
                            height: 150,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.dateAndTime,
                              onDateTimeChanged: (value) {
                                argument.scheduleData = value;
                              },
                              // initialDateTime: DateTime.now(),
                              minimumDate: DateTime.now(),
                              maximumDate:
                                  DateTime.now().add(Duration(days: 1)),
                              use24hFormat: true,
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          if (argument.scheduleData == null) {
                            Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cart.items.values.toList(),
                              cart.totalAmount,
                            );
                            updatedb();

                            Navigator.of(context).pushNamed(
                                StatusScreen.routeName,
                                arguments: Arguments(
                                    roomNumberData: argument.roomNumberData));
                          } else {
                            Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cart.items.values.toList(),
                              cart.totalAmount,
                            );
                            scheduleddb();

                            Navigator.of(context).pushNamed(
                                StatusScreen.routeName,
                                arguments: Arguments(
                                    roomNumberData: argument.roomNumberData,
                                    scheduleData: argument.scheduleData));
                          }
                        },
                        child: _enable
                            ? const Text('Confirm Order',
                                style: TextStyle(color: kYellowColor))
                            : const Text('I have Completed Payment',
                                style: TextStyle(color: kYellowColor)),
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
                              content:
                                  const Text('Your order data will be cleared'),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: kYellowColor),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(true);
                                    cart.clear();
                                    Navigator.of(context).pushNamed('/');
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: kYellowColor),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        child: const Text('Cancel Purchase',
                            style: TextStyle(color: kPrimaryColor)),
                        style: ElevatedButton.styleFrom(primary: kYellowColor),
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
              );
            }),
      ),
    );
  }
}
