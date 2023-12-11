import 'dart:ffi';

import 'package:desafio_tecnico_final/books/data/http/http_client.dart';
import 'package:desafio_tecnico_final/books/data/repository/book_repository.dart';
import 'package:desafio_tecnico_final/books/pages/stores/book_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/book.dart';
import 'components/books_tile.dart';
import 'components/drawer.dart';
import '../data/models/book_list.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

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

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const MyDrawer(),
        appBar: AppBar(
          //iconTheme: IconThemeData(color: Colors.amber),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,

          // logo
          title: const ImageIcon(
            AssetImage('assets/logos/ebooks.png'),
            size: 120,
          ),
          // theme switch
          actions: <Widget>[
            IconButton(
              icon: Get.isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
            )
          ],
        ),
        body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              );
            } else if (store.erro.value.isNotEmpty) {
              return Container(
                child: Text('deu ruim' + store.erro.value),
              );
            } else if (store.state.value.isEmpty) {
              return Container(
                child: Text('Nenhum livro na lista'),
              );
            } else if (store.state.value.isNotEmpty) {
              books = store.state.value;
              return _content(context, books);
            } else {
              return Container();
            }
          },
        ));
  }

// body
  Widget _content(context, books) {
    return Column(
      children: [
        // title
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 20, 5),
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
