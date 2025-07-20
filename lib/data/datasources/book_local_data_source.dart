import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book_model.dart';

abstract class BookLocalDataSource {
  Future<void> saveBook(BookModel book);
  Future<List<BookModel>> getSavedBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE books(title TEXT, author TEXT, coverUrl TEXT)',
        );
      },
    );
  }

  @override
  Future<void> saveBook(BookModel book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<BookModel>> getSavedBooks() async {
    final db = await database;
    final maps = await db.query('books');
    return maps.map((e) => BookModel.fromDb(e)).toList();
  }
}
