import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;

  const ImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kblackColor,
          boxShadow: const[
            BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
          ]),
      child: ClipRRect(
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
                  child: Center(
                    // child: BlurHash(
                    //   imageFit: BoxFit.cover,
                    //   duration: const Duration(seconds: 4),
                    //   curve: Curves.bounceInOut,
                    //   hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                    //   image: imageUrl,
                    // ),
                  ));
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
                  size: 30.0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
