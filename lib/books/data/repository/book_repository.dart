import 'dart:convert';


import 'package:desafio_tecnico_final/books/data/http/exceptions.dart';
import 'package:desafio_tecnico_final/books/data/http/http_client.dart';
import 'package:desafio_tecnico_final/books/data/models/book.dart';

abstract class IBookRepository {
  Future<List<BookModel>> getBooks();
}

class BookRepository implements IBookRepository {
  final IHttpClient client;

  BookRepository({required this.client});

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await client.get(
      url: 'https://escribo.com/books.json',
    );

    if (response.statusCode == 200) {
      final List<BookModel> books = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final BookModel bookModel = BookModel.fromMap(item);
        books.add(bookModel);
      }).toList();

      return books;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada é inválida.');
    } else {
      throw Exception('Não foi possível carregar os livros.');
    }
  }
}
