import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class SearchBooksEvent extends BookEvent {
  final String query;
  final int page;
  const SearchBooksEvent(this.query, {this.page = 1});
  @override
  List<Object?> get props => [query, page];
}

class LoadSavedBooksEvent extends BookEvent {
  @override
  List<Object?> get props => [];
}

class SaveBookEvent extends BookEvent {
  final String title, author, coverUrl;
  const SaveBookEvent(this.title, this.author, this.coverUrl);
  @override
  List<Object?> get props => [title, author, coverUrl];
}
