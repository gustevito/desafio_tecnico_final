import 'package:flutter/material.dart';

import 'book.dart';

class BookList extends ChangeNotifier {
  // livros
  final List<BookModel> _booklist = [];

  // favoritos
  final List<BookModel> _favorites = [];
  // get livros
  List<BookModel> get booklist => _booklist;
  // get favoritos
  List<BookModel> get favorites => _favorites;
  // adicionar livro aos favoritos
  void addToFavorites(BookModel item) {
    _favorites.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromFavorites(BookModel item) {
    _favorites.remove(item);
    notifyListeners();
  }

  setList(List<BookModel> books) {
    _booklist.clear();
    _booklist.addAll(books);
  }
}
