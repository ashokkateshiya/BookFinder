import '../entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query, int page);
  Future<void> storeBook(Book book);
  Future<List<Book>> getBooks();
}
