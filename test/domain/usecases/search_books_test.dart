import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bookfinder/domain/usecases/search_books.dart';
import 'package:bookfinder/domain/entities/book.dart';
import 'package:bookfinder/domain/repositories/book_repository.dart';
import 'package:mockito/annotations.dart';

// Generate mock class
@GenerateMocks([BookRepository])
import 'search_books_test.mocks.dart';

void main() {
  late MockBookRepository mockRepository;
  late SearchBooks usecase;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = SearchBooks(mockRepository);
  });

  test(
    'should return List<Book> when repository returns data successfully',
    () async {
      const query = 'flutter';
      const page = 1;
      final bookList = [
        Book(
          title: 'Flutter Complete Guide',
          author: 'Google',
          coverUrl: 'url.jpg',
        ),
      ];

      // Proper mock return (prevents null type error)
      when(
        mockRepository.searchBooks(query, page),
      ).thenAnswer((_) async => bookList);

      final result = await usecase.call(query, page);

      expect(result, bookList);
      verify(mockRepository.searchBooks(query, page)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should throw exception when repository throws error', () async {
    const query = 'flutter';
    const page = 1;

    when(
      mockRepository.searchBooks(query, page),
    ).thenThrow(Exception('Error fetching data'));

    expect(() => usecase.call(query, page), throwsException);
    verify(mockRepository.searchBooks(query, page)).called(1);
  });
}
