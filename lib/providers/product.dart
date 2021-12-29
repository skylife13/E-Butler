import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;
  int quantity;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    this.quantity = 0,
    @required this.imageUrl,
  });
  void toggleDone() {
    quantity++;
  }

  void decreaseDown() {
    quantity == 0 ? 0 : quantity--;
  }
}
