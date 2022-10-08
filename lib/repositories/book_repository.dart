import 'dart:convert';
import 'package:http/http.dart';

class Book {
  final String title;
  final String numOfPages;
  final String date;
  final String description;
  final String bookUrl;
  String? imageUrl;

  Book({
    required this.title,
    required this.numOfPages,
    required this.date,
    required this.description,
    required this.bookUrl,
    this.imageUrl,
  });

  Book.fromMap(Map<String, dynamic> item)
      : numOfPages = item['volumeInfo']?['pageCount']?.toString() != null
            ? 'Páginas: ${item['volumeInfo']['pageCount'].toString()}'
            : 'Número de páginas no disponible.',
        title = item['volumeInfo']?['title'] ?? '- Sin título. -',
        date =
            item['volumeInfo']?['publishedDate'] ?? '- Sin año de publicación.',
        imageUrl = item['volumeInfo']?['imageLinks']?['thumbnail'],
        description = item['volumeInfo']?['description'] ?? 'Sin descripción.',
        bookUrl = item['volumeInfo']?['infoLink'] ?? 'Link no disponible.';
}

class BookRepository {
  final String googleApiUrl = 'www.googleapis.com';
  final String googleApiUrlPath = '/books/v1/volumes';

  BookRepository();

  Future<List<Book>> getAll(String query) async {
    final Uri uri = Uri.https(googleApiUrl, googleApiUrlPath, {'q': query});
    final Response booksResponse =
        await get(uri, headers: {'Content-Type': 'application/json'});
    if (booksResponse.statusCode != 200) {
      throw Exception();
    }
    final dynamic booksBody = jsonDecode(booksResponse.body);
    final List<dynamic> items = booksBody['items'] ?? [];
    return items.map((item) => Book.fromMap(item)).toList();
  }
}
