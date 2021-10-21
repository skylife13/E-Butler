import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Cola',
      description:
          'Coca Cola, a nice soft drink, drink too much and your health will most likely take a toll',
      price: 6000,
      imageUrl: 'https://genkisushi.co.id/media/2020/06/coke.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Pillow',
      description: 'A nice fluffy comfy pillow that will make you feel drowsy.',
      price: 0,
      imageUrl:
          'https://wakefit-co.s3.ap-south-1.amazonaws.com/img/memory-foam-pillows/memory-foam-pillows-4.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Towel',
      description:
          'Towel to keep your body nice and dry, it\'s soft to care for your skin.',
      price: 0,
      imageUrl:
          'https://image.freepik.com/free-psd/pile-towels-white_176382-1916.jpg',
    ),
    Product(
      id: 'p4',
      title: '600ml Mineral Water',
      description: 'Keep your body hydrated.',
      price: 3000,
      imageUrl: 'https://cdn1.productnation.co/stg/sites/5/5d93142e2a796.jpeg',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  // List<Product> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}
