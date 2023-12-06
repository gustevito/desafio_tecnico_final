import 'package:flutter/material.dart';

import 'book.dart';

class BookList extends ChangeNotifier {
  // livros
  final List<BookModel> _booklist = [];

  // favoritos
  final List<BookModel> _cart = [];
  // get livros
  List<BookModel> get booklist => _booklist;
  // get favoritos
  List<BookModel> get cart => _cart;
  // adicionar livro aos favoritos
  void addToCart(BookModel item) {
    _cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(BookModel item) {
    _cart.remove(item);
    notifyListeners();
  }

  setList(List<BookModel> books) {
    _booklist.clear();
    _booklist.addAll(books);
  }
}
