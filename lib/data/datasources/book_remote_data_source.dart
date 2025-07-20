import 'package:dio/dio.dart';
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> searchBooks(String query, int page);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;
  BookRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookModel>> searchBooks(String query, int page) async {
    try {
      final response = await dio.get(
        'https://openlibrary.org/search.json',
        queryParameters: {'q': query, 'page': page},
      );

      final docs = response.data['docs'] as List;
      return docs.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching books');
    }
  }
}
