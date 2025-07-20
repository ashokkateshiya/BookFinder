import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../../generated/l10n.dart';
import '../../core/di/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsScreen extends StatefulWidget {
  final Book book;
  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final BookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl<BookBloc>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveBook() {
    bloc.add(
      SaveBookEvent(
        widget.book.title,
        widget.book.author,
        widget.book.coverUrl,
      ),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Book saved successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title, overflow: TextOverflow.ellipsis),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: widget.book.coverUrl,
                      width: 180,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        width: 180,
                        height: 250,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 180,
                        height: 250,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.menu_book_rounded, size: 50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.book.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.book.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _saveBook,
                  icon: const Icon(Icons.save),
                  label: Text("Save Book"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
