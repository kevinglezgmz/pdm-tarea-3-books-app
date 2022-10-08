part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksInitialState extends BooksState {}

class BooksSeachingState extends BooksState {}

class BooksSearchSuccessState extends BooksState {
  final List<Book> books;
  const BooksSearchSuccessState({required this.books});
  @override
  List<Object> get props => [books];
}

class BooksErrorState extends BooksState {
  final String errorMessage;
  const BooksErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
