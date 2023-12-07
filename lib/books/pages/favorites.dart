import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desafio_tecnico_final/books/pages/components/button.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/http/http_client.dart';
import '../data/repository/book_repository.dart';
import 'components/books_tile.dart';
import 'components/favs_tile.dart';
import '../data/models/book.dart';
import '../data/models/book_list.dart';
import 'stores/book_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookModel> books = [];
    //context.watch<BookList>().booklist;

    final BookState store = BookState(
      repository: BookRepository(
        client: HttpClient(),
      ),
    );

    store.getBooks();
    final cart = context.watch<BookList>().favorites;

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
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 380,
                  mainAxisExtent: 400,
                ),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  // get item in cart
                  final item = cart[index];

                  // return as a cart tile
                  return BookTileFavorite(
                      title: Text(item.title),
                      subtitle: Text(item.author),
                      book: item,
                      onPressed: () {});
                }),
          ),
        ],
      ),
    );
  }

  Widget _content(context, books) {
    return Column(
      children: [
        // title
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // subtitle
                  Text(
                    'Livros',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.collections_bookmark,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/favorites');
                  },
                ),
              ),
            ],
          ),
        ),
        // books
        Flexible(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380,
              mainAxisExtent: 400,
            ),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10),
            itemCount: books.length,
            itemBuilder: ((context, index) {
              // get each book from the booklist
              final book = books[index];

              // return UI element
              return BookTile(book: book);
            }),
          ),
        ),
      ],
    );
  }
}
