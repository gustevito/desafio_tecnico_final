import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../data/models/book.dart';
import '../../data/models/book_list.dart';

class BookTile extends StatelessWidget {
  final BookModel book;

  const BookTile({
    super.key,
    required this.book,
  });

  // add to cart
  void addToCart(BuildContext context) {
    // dialog box to confirm
    context.read<BookList>().addToCart(book);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(10),
          width: 200,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Image.network(
                        book.cover,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 300,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.bookmark_add,
                        color: Color.fromARGB(255, 230, 203, 51),
                        shadows: [
                          Shadow(
                              color: Color.fromARGB(94, 0, 0, 0),
                              blurRadius: 10.0)
                        ],
                        size: 30,
                      ),
                      onPressed: () {
                        var snack;
                        void closeSnack() {
                          snack.close();
                        }

                        Get.closeCurrentSnackbar();
                        snack = Get.snackbar(
                          'Livro favoritado!',
                          book.title,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          animationDuration: const Duration(milliseconds: 200),
                          mainButton: TextButton(
                            onPressed: () {
                              context.read<BookList>().removeFromCart(book);
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
                                'Desfazer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );

                        addToCart(context);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        // name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.josefinSans(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        // description
        Text(
          book.author,
          style: GoogleFonts.josefinSans(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
