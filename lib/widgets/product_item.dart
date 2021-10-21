import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product.dart';
import '/providers/cart.dart';
import '/Screens/Home/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    int quantity = 0;

    // bool buttonState = false;

    //print('it rebuilds'); //just to check consumer
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
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          // leading: Consumer<Product>(
          //   builder: (ctx, product, _) => IconButton(
          //     icon: Icon(
          //         product.isFavorite ? Icons.favorite : Icons.favorite_border),
          //     onPressed: () {
          //       product.toggleFavoriteStatus();
          //     },
          //     color: Theme.of(context).accentColor,
          //   ),
          // ),
          backgroundColor: Colors.black54,
          title: Consumer<Cart>(
            builder: (_, cart, child) => Stack(
              children: [
                Center(
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Text(
            'Rp.${product.price.toString()}',
          ),
          leading: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              cart.removeSingleItem(product.id); //ganti jadi remove item
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: quantity != 0
                      ? const Text(
                          'Removed Item From Cart',
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'Add Item First',
                          textAlign: TextAlign.center,
                        ),
                  duration: const Duration(seconds: 1),
                  // action: SnackBarAction(
                  //   label: 'Undo',
                  //   onPressed: () {
                  //     cart.removeSingleItem(
                  //         product.id);
                  //   },
                  // ),
                ),
              );
              if (quantity < 1) {
                quantity = 0;
              } else {
                quantity -= 1;
              }
            },
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Added item to cart!',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 1),
                  // action: SnackBarAction(
                  //   label: 'Undo',
                  //   onPressed: () {
                  //     cart.removeSingleItem(product.id);
                  //     quantity -= 1;
                  //   },
                  // ),
                ),
              );
              quantity += 1;
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
//final product = Provider.of<Product>(context) or use consumer;
//use consumer because provider.of will rerun the entire build method
//or can also use provider.of for some widgets that are not going to change like title, etc
//and can only wrap the favorite button using the consumer since it's the only thing that can change

// Consumer<Product>(
//       builder: (ctx, product, child) => ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: GridTile(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
//                   arguments: product.id);
//             },
//             child: Image.network(
//               product.imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//           footer: GridTileBar(
//             leading: IconButton(
//               icon: Icon(
//                   product.isFavorite ? Icons.favorite : Icons.favorite_border),
//               onPressed: () {
//                 product.toggleFavoriteStatus();
//               },
//               color: Theme.of(context).accentColor,
//             ),
//             backgroundColor: Colors.black54,
//             title: Text(
//               product.title,
//               textAlign: TextAlign.center,
//             ),
//             trailing: IconButton(
//               icon: Icon(
//                 Icons.shopping_cart,
//               ),
//               onPressed: () {},
//               color: Theme.of(context).accentColor,
//             ),
//           ),
//         ),
//       ),
//     );
