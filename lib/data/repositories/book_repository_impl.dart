import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_local_data_source.dart';
import '../datasources/book_remote_data_source.dart';
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remote;
  final BookLocalDataSource local;

  BookRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Book>> searchBooks(String query, int page) async {
    final books = await remote.searchBooks(query, page);
    return books;
  }

  @override
  Future<void> storeBook(Book book) async {
    await local.saveBook(
      BookModel(
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
      ),
    );
  }

  @override
  Future<List<Book>> getBooks() async {
    return await local.getSavedBooks();
  }
}
