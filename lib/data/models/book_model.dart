import '../../domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required String title,
    required String author,
    required String coverUrl,
  }) : super(title: title, author: author, coverUrl: coverUrl);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? 'No Title',
      author: (json['author_name'] as List?)?.first ?? 'Unknown',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'coverUrl': coverUrl,
  };

  factory BookModel.fromDb(Map<String, dynamic> json) => BookModel(
    title: json['title'],
    author: json['author'],
    coverUrl: json['coverUrl'],
  );
}
