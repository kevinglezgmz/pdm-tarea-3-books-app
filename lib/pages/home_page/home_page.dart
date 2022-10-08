import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tarea_3_books_app/blocs/bloc/books_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3_books_app/pages/book_details_page/book_details_page.dart';
import 'package:tarea_3_books_app/pages/home_page/book_grid_tile.dart';
import 'package:tarea_3_books_app/pages/home_page/empty_book_grid_tile.dart';
import 'package:tarea_3_books_app/repositories/book_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchQueyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libería Free to Play'),
      ),
      body: Column(
        children: [
          _getSearchTextField(searchQueyController, context),
          _getBooksBlocConsumer(),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  BlocConsumer _getBooksBlocConsumer() {
    return BlocConsumer<BooksBloc, BooksState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is BooksInitialState) {
          return _getInitialBooksStateComponent();
        } else if (state is BooksSeachingState) {
          return _getSearchingBooksComponent();
        } else if (state is BooksErrorState) {
          return _getSearchErrorStateComponent(state.errorMessage);
        } else if (state is BooksSearchSuccessState) {
          if (state.books.isNotEmpty) {
            return _getSearchSuccessComponent(state.books);
          } else {
            return _getNoResultsComponent();
          }
        } else {
          return _getUnknownStateComponent();
        }
      },
    );
  }

  Expanded _getSearchSuccessComponent(List<Book> books) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.70,
          ),
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetailsPage(
                        book: books[index],
                      ),
                    ),
                  );
                },
                child: BookGridTile(book: books[index]));
          },
        ),
      ),
    );
  }

  Expanded _getUnknownStateComponent() {
    return const Expanded(
      child: Center(
        child: Text(
          'Unknown error.',
        ),
      ),
    );
  }

  Expanded _getNoResultsComponent() {
    return const Expanded(
      child: Center(
        child: Text(
          'No se encontraron títulos, intenta con otro término.',
        ),
      ),
    );
  }

  Expanded _getSearchErrorStateComponent(String errorMessage) {
    return Expanded(
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Expanded _getInitialBooksStateComponent() {
    return const Expanded(
      child: Center(
        child: Text('Ingresa algún título para buscar.'),
      ),
    );
  }

  Widget _getSearchingBooksComponent() {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(155, 185, 185, 185),
        highlightColor: const Color.fromARGB(150, 234, 234, 234),
        period: const Duration(milliseconds: 1200),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.70,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const EmptyBookGridTile();
            },
          ),
        ),
      ),
    );
  }

  Padding _getSearchTextField(
      TextEditingController searchQueyController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          _triggerSearchEvent(context, searchQueyController);
        },
        controller: searchQueyController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: const Text('Ingresar título'),
          suffixIcon: GestureDetector(
            onTap: () {
              _triggerSearchEvent(context, searchQueyController);
            },
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  void _triggerSearchEvent(
      BuildContext context, TextEditingController searchQueyController) {
    context.read<BooksBloc>().add(
          BooksSearchEvent(
            query: searchQueyController.text,
          ),
        );
  }
}
