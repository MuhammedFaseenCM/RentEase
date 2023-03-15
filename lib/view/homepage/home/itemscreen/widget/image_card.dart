import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;

  const ImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        imageUrl,
        width: 300.0,
        height: 250.0,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Container(
              decoration: BoxDecoration(
                color: kgrey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: 300.0,
              height: 250.0,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: kgrey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: 300.0,
            height: 250.0,
            child: const Center(
              child: Icon(
                Icons.error,
                color: kwhiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
