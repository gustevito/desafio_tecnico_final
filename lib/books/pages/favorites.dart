import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desafio_tecnico_final/books/pages/components/button.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/favs_tile.dart';
import '../data/models/book.dart';
import '../data/models/book_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove from cart function
  void removeItemFromCart(BuildContext context, BookModel book) {
    context.read<BookList>().removeFromCart(book);
  }

  void payButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text(
            'It works! Connect this app to your payment backend and you\'re good to go'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<BookList>().cart;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Colors.amber),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Livros Favoritos',
          style: GoogleFonts.dmSerifDisplay(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          // cart list
          Expanded(
            child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  // get item in cart
                  final item = cart[index];

                  // return as a cart tile
                  return CartTile(
                      title: Text(item.title),
                      subtitle: Text(item.author),
                      onPressed: () {
                        var snack;
                        void closeSnack() {
                          snack.close();
                        }

                        int removeIndex = index;

                        BookModel book = item;

                        Get.closeCurrentSnackbar();
                        snack = Get.snackbar(
                          'BookModel Removed',
                          book.title,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          animationDuration: const Duration(milliseconds: 200),
                          mainButton: TextButton(
                            onPressed: () {
                              if (removeIndex != -1) {
                                context.read<BookList>().addToCart(book);
                                removeIndex = -1;
                              }
                              closeSnack();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Undo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );

                        removeItemFromCart(context, item);
                      });
                }),
          ),
        ],
      ),
    );
  }
}
