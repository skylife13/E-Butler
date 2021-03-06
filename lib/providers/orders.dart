import 'package:flutter/cupertino.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  int get itemCount {
    return _orders.length;
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    // DatabaseService(uid: user.uid).updateUserData(
    //   DateTime.now().toString(),
    //   total,
    //   cartProducts,
    //   DateTime.now(),
    // );
    //kalo taro sini, nanti bakal bikin document baru tiap dia order dengan uid unik khusus order itu
    //jadi bisa bikin kayak history page bwt admin, bikin datany jadi ada data user dkk
    notifyListeners();
  }
}
