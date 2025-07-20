import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/locator.dart';
import '../../domain/entities/book.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import '../widgets/book_item_widget.dart';
import 'details_screen.dart';

class SavedBooksScreen extends StatefulWidget {
  const SavedBooksScreen({super.key});

  @override
  State<SavedBooksScreen> createState() => _SavedBooksScreenState();
}

class _SavedBooksScreenState extends State<SavedBooksScreen> {
  late BookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl<BookBloc>();
    bloc.add(LoadSavedBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Saved Books')),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SavedBooksLoaded) {
              final savedBooks = state.savedBooks;
              if (savedBooks.isEmpty) {
                return const Center(child: Text('No saved books found.'));
              }
              return ListView.builder(
                itemCount: savedBooks.length,
                itemBuilder: (context, index) {
                  final book = savedBooks[index];
                  return BookItemWidget(
                    book: Book(
                      title: book.title,
                      author: book.author,
                      coverUrl: book.coverUrl,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(book: book),
                        ),
                      );
                    }, // Optionally open details page
                  );
                },
              );
            } else if (state is BookError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
