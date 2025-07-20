import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(width: 50, height: 50, color: Colors.white),
            title: Container(height: 10, color: Colors.white),
            subtitle: Container(height: 10, width: 100, color: Colors.white),
          ),
        );
      },
    );
  }
}
