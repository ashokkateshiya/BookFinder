// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Book Finder';

  @override
  String get searchHint => 'Search books...';

  @override
  String get noBooksFound => 'No books found.';

  @override
  String get bookSaved => 'Book saved successfully!';

  @override
  String get errorMessage => 'Something went wrong!';

  @override
  String get savedBooks => 'Saved Books';
}
