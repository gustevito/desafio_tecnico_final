import 'package:desafio_tecnico_final/books/data/models/book.dart';
import 'package:desafio_tecnico_final/books/data/repository/book_repository.dart';
import 'package:flutter/material.dart';

import '../../data/http/exceptions.dart';

class BookState {
  final IBookRepository repository;

  // loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  // state
  final ValueNotifier<List<BookModel>> state =
      ValueNotifier<List<BookModel>>([]);
  // error
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  BookState({required this.repository});

  getBooks() async {
    isLoading.value = true;

    try {
      final result = await repository.getBooks();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
