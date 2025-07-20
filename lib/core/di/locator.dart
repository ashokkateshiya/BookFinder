/* import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/datasources/book_local_data_source.dart';
import '../../data/datasources/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/search_books.dart';
import '../../presentation/bloc/book_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies
  locator.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  locator.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<BookLocalDataSource>(
    () => BookLocalDataSourceImpl(),
  );

  // Repository
  locator.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(locator(), locator()),
  );

  // Usecases
  locator.registerLazySingleton<SearchBooks>(() => SearchBooks(locator()));

  // BLoC
  locator.registerFactory(
    () => BookBloc(
      searchBooks: locator(),
      repository: locator() as BookRepositoryImpl,
    ),
  );
}
 */
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/book_local_data_source.dart';
import '../../data/datasources/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/search_books.dart';
import '../../presentation/bloc/book_bloc.dart';

final sl = GetIt.instance; // Correct initialization

Future<void> setupLocator() async {
  //External Libraries
  sl.registerLazySingleton<Dio>(() => Dio());

  //Data Sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<BookLocalDataSource>(
    () => BookLocalDataSourceImpl(),
  );

  //Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      sl<BookRemoteDataSource>(),
      sl<BookLocalDataSource>(),
    ),
  );

  //Use Cases
  sl.registerLazySingleton<SearchBooks>(
    () => SearchBooks(sl<BookRepository>()),
  );

  //BLoC
  sl.registerFactory(
    () => BookBloc(
      searchBooks: sl<SearchBooks>(),
      repository: sl<BookRepository>() as BookRepositoryImpl,
    ),
  );
}
