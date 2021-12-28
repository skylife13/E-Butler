import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product.dart';
import '/providers/cart.dart';
import '/Screens/Home/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        header: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),

        // footer: GridTileBar(
        //   backgroundColor: Colors.black54,
        //   title: Consumer<Cart>(
        //     builder: (_, cart, child) => Stack(
        //       children: [
        //         Center(
        //           child: Text(
        //             product.quantity.toString(),
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   // subtitle: Text(
        //   //   'Rp.${product.price.toStringAsFixed(0)}',
        //   // ),
        //   // leading: IconButton(
        //   //   icon: const Icon(Icons.remove),
        //   //   onPressed: () {
        //   //     cart.removeSingleItem(product.id); //ganti jadi remove item
        //   //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   //     ScaffoldMessenger.of(context).showSnackBar(
        //   //       SnackBar(
        //   //         content: product.quantity != 0
        //   //             ? const Text(
        //   //                 'Removed Item From Cart',
        //   //                 textAlign: TextAlign.center,
        //   //               )
        //   //             : const Text(
        //   //                 'Add Item First',
        //   //                 textAlign: TextAlign.center,
        //   //               ),
        //   //         duration: const Duration(seconds: 1),
        //   //       ),
        //   //     );
        //   //     if (product.quantity < 1) {
        //   //       product.quantity = 0;
        //   //     } else {
        //   //       product.quantity -= 1;
        //   //     }
        //   //   },
        //   //   color: Theme.of(context).accentColor,
        //   // ),
        //   // trailing: IconButton(
        //   //   icon: const Icon(
        //   //     Icons.add,
        //   //   ),
        //   //   onPressed: () {
        //   //     cart.addItem(
        //   //         product.id, product.price, product.title, product.quantity);
        //   //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   //     ScaffoldMessenger.of(context).showSnackBar(
        //   //       const SnackBar(
        //   //         content: Text(
        //   //           'Added item to cart!',
        //   //           textAlign: TextAlign.center,
        //   //         ),
        //   //         duration: Duration(seconds: 1),
        //   //       ),
        //   //     );
        //   //     product.quantity += 1;
        //   //   },
        //   //   color: Theme.of(context).accentColor,
        //   // ),
        // ),

        // child: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
        //         arguments: product.id);
        //   },
        //   child: Image.network(
        //     product.imageUrl,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }
}
