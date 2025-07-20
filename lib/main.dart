import 'package:flutter/material.dart';
import 'core/di/locator.dart';
import 'presentation/screens/search_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const BookFinderApp());
}

class BookFinderApp extends StatelessWidget {
  const BookFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Book Finder",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      /* localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // */
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SearchScreen(),
    );
  }
}
