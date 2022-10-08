part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksSearchEvent extends BooksEvent {
  final String query;

  const BooksSearchEvent({required this.query});
  @override
  List<Object> get props => [query];
}
