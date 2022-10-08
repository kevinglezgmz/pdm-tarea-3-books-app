import 'package:flutter/material.dart';
import 'package:tarea_3_books_app/repositories/book_repository.dart';

class BookGridTile extends StatelessWidget {
  final Book book;
  const BookGridTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (book.imageUrl != null)
            Expanded(
              flex: 11,
              child: Image.network(
                book.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          if (book.imageUrl == null)
            Expanded(
              flex: 11,
              child: Image.asset(
                'assets/no_cover.jpg',
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                book.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
