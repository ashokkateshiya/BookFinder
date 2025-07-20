import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:bookfinder/presentation/bloc/book_bloc.dart';
import 'package:bookfinder/presentation/bloc/book_event.dart';
import 'package:bookfinder/presentation/bloc/book_state.dart';
import 'package:bookfinder/domain/usecases/search_books.dart';
import 'package:bookfinder/domain/entities/book.dart';
import 'package:bookfinder/data/repositories/book_repository_impl.dart';

//Generate Mocks using Mockito
@GenerateMocks([SearchBooks, BookRepositoryImpl])
import 'book_bloc_test.mocks.dart';

void main() {
  late MockSearchBooks mockSearchBooks;
  late MockBookRepositoryImpl mockRepository;
  late BookBloc bookBloc;

  setUp(() {
    mockSearchBooks = MockSearchBooks();
    mockRepository = MockBookRepositoryImpl();
    bookBloc = BookBloc(
      searchBooks: mockSearchBooks,
      repository: mockRepository,
    );
  });

  const testQuery = 'flutter';
  final testBooks = [
    Book(title: 'Flutter Book', author: 'Google', coverUrl: 'cover.png'),
  ];

  blocTest<BookBloc, BookState>(
    'emits [BookLoading, BookLoaded] when SearchBooks succeeds',
    build: () {
      when(
        mockSearchBooks.call(testQuery, 1),
      ).thenAnswer((_) async => testBooks);
      return bookBloc;
    },
    act: (bloc) => bloc.add(const SearchBooksEvent(testQuery)),
    expect: () => [BookLoading(), BookLoaded(testBooks)],
    verify: (_) {
      verify(mockSearchBooks.call(testQuery, 1)).called(1);
    },
  );

  blocTest<BookBloc, BookState>(
    'emits [BookLoading, BookError] when SearchBooks throws exception',
    build: () {
      when(
        mockSearchBooks.call(testQuery, 1),
      ).thenThrow(Exception('Failed to fetch'));
      return bookBloc;
    },
    act: (bloc) => bloc.add(const SearchBooksEvent(testQuery)),
    expect: () => [BookLoading(), isA<BookError>()],
    verify: (_) {
      verify(mockSearchBooks.call(testQuery, 1)).called(1);
    },
  );
}
