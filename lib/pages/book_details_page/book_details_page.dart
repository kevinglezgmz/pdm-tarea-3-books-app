import 'package:flutter/material.dart';
import 'package:tarea_3_books_app/components/toggable_text/toggable_text.dart';
import 'package:tarea_3_books_app/repositories/book_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del libro'), actions: [
        IconButton(
            onPressed: () {
              if (book.bookUrl != 'Link no disponible.') {
                launchUrlString(
                  book.bookUrl,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Link al libro no disponible...'),
                    ),
                  );
              }
            },
            icon: const Icon(Icons.public)),
        IconButton(
            onPressed: () {
              Share.share(
                  'Te comparto el libro \'${book.title}\' (${book.numOfPages}) disponible en: ${book.bookUrl}',
                  subject: 'Mira este libro!');
            },
            icon: const Icon(Icons.share)),
      ]),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getBookImage(book, height),
              _getToggableTitle(),
              _getBookTextDetails()
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Column _getBookTextDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _getPublishedDate(),
        const SizedBox(height: 4),
        _getNumberOfPages(),
        const SizedBox(height: 4),
        _getToggableDescription(),
      ],
    );
  }

  Text _getNumberOfPages() {
    return Text(
      book.numOfPages,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }

  Text _getPublishedDate() {
    return Text(
      book.date,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Padding _getToggableTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Center(
        child: ToggableText(
          text: book.title,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  ToggableText _getToggableDescription() {
    return ToggableText(
      text: book.description,
      maxLines: 10,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 16,
      ),
    );
  }

  Widget _getBookImage(Book book, double height) {
    String? thumbnail = book.imageUrl;
    return SizedBox(
      height: height * .35 > 200 ? height * .35 : 200,
      child: AspectRatio(
        aspectRatio: 9 / 14,
        child: thumbnail != null
            ? Image.network(
                thumbnail,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/no_cover.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
