import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_event.dart';
import 'book_state.dart';
import '../../domain/usecases/search_books.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final SearchBooks searchBooks;
  final BookRepositoryImpl repository;

  BookBloc({required this.searchBooks, required this.repository})
    : super(BookInitial()) {
    on<SearchBooksEvent>(_onSearchBooks);
    on<LoadSavedBooksEvent>(_onLoadSavedBooks);
    on<SaveBookEvent>(_onSaveBook);
  }

  Future<void> _onSearchBooks(
    SearchBooksEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    try {
      final books = await searchBooks(event.query, event.page);
      emit(BookLoaded(books, isPagination: event.page > 1));
    } catch (_) {
      emit(const BookError("Something went wrong while fetching books"));
    }
  }

  Future<void> _onLoadSavedBooks(
    LoadSavedBooksEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    try {
      final saved = await repository.getBooks();
      emit(SavedBooksLoaded(saved));
    } catch (_) {
      emit(const BookError("Failed to load saved books"));
    }
  }

  Future<void> _onSaveBook(SaveBookEvent event, Emitter<BookState> emit) async {
    try {
      await repository.storeBook(
        Book(
          title: event.title,
          author: event.author,
          coverUrl: event.coverUrl,
        ),
      );
      emit(const BookSaved("Book saved successfully!"));
    } catch (_) {
      emit(const BookError("Failed to save book"));
    }
  }
}
