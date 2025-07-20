import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitial extends BookState {
  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {
  @override
  List<Object?> get props => [];
}

class BookLoaded extends BookState {
  final List<Book> books;
  final bool isPagination;
  const BookLoaded(this.books, {this.isPagination = false});
  @override
  List<Object?> get props => [books, isPagination];
}

class BookError extends BookState {
  final String message;
  const BookError(this.message);
  @override
  List<Object?> get props => [message];
}

class BookSaved extends BookState {
  final String message;
  const BookSaved(this.message);
  @override
  List<Object?> get props => [message];
}

class SavedBooksLoaded extends BookState {
  final List<Book> savedBooks;
  const SavedBooksLoaded(this.savedBooks);
  @override
  List<Object?> get props => [savedBooks];
}
