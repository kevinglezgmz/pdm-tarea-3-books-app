import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarea_3_books_app/repositories/book_repository.dart';

part 'books_event.dart';
part 'books_state.dart';

const String googleApiUrl = 'www.googleapis.com';
const String googleApiUrlPath = '/books/v1/volumes';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BookRepository _bookRepository;

  BooksBloc({required bookRepository})
      : _bookRepository = bookRepository,
        super(BooksInitialState()) {
    on<BooksSearchEvent>(_booksSearchEventHandler);
  }

  FutureOr<void> _booksSearchEventHandler(
      BooksSearchEvent event, Emitter emit) async {
    emit(BooksSeachingState());
    try {
      final List<Book> books = await _bookRepository.getAll(event.query);
      emit(BooksSearchSuccessState(books: books));
    } on Exception {
      emit(
        const BooksErrorState(
          errorMessage:
              'Ha ocurrido un error al buscar los libros. Por favor intenta de nuevo.',
        ),
      );
    }
  }
}
