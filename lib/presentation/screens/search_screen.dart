import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/locator.dart';
import '../../domain/entities/book.dart';
import '../../generated/l10n.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import '../widgets/book_item_widget.dart';
import '../widgets/shimmer_widget.dart';
import 'details_screen.dart';
import 'saved_books_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late BookBloc bloc;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Book> _books = [];
  int _page = 1;
  String _query = '';

  @override
  void initState() {
    super.initState();
    bloc = sl<BookBloc>();
    _controller.addListener(
      () => setState(() {}),
    ); // Refresh UI for clear button
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _page += 1;
      bloc.add(SearchBooksEvent(_query, page: _page));
    }
  }

  void _searchBooks() {
    FocusScope.of(context).unfocus(); // Hide keyboard
    _page = 1;
    _query = _controller.text.trim();
    bloc.add(SearchBooksEvent(_query, page: _page));
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _books.clear();
      _query = '';
    });
  }

  Future<void> _refreshBooks() async {
    _page = 1;
    _query = _controller.text.trim();
    bloc.add(SearchBooksEvent(_query, page: _page));
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Let the indicator show
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Finder"),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark),
              tooltip: 'Saved Books',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SavedBooksScreen()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _searchBooks(),
                  decoration: InputDecoration(
                    hintText: "Search Books",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearSearch,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // List with Pull-to-Refresh and Pagination
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshBooks,
                  child: BlocConsumer<BookBloc, BookState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is BookError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      } else if (state is BookLoaded) {
                        if (_page == 1) {
                          _books = state.books;
                        } else {
                          _books.addAll(state.books);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is BookLoading && _page == 1) {
                        return const ShimmerWidget();
                      }
                      if (_books.isEmpty) {
                        return Center(
                          child: Text(
                            "No books found",
                          ), // S.of(context).noBooksFound),
                        );
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          return BookItemWidget(
                            book: _books[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(book: _books[index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
