import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3_books_app/blocs/bloc/books_bloc.dart';
import 'package:tarea_3_books_app/pages/home_page/home_page.dart';
import 'package:tarea_3_books_app/repositories/book_repository.dart';

void main() => runApp(RepositoryProvider(
      create: (context) => BookRepository(),
      child: BlocProvider(
        create: (context) =>
            BooksBloc(bookRepository: context.read<BookRepository>()),
        child: const MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 241, 241),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 100, 100, 100),
        ),
      ),
      home: const HomePage(),
    );
  }
}
