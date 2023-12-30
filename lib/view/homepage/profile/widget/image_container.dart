import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class MyGadgetImageContainer extends StatelessWidget {
  final double? size;
  final String image;
  const MyGadgetImageContainer({super.key, required this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(image,
            fit: BoxFit.cover, height: size ?? 100.0, width: size ?? 100.0,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Container(
                decoration: BoxDecoration(
                  color: kgrey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: size ?? 100.0,
                height: size ?? 100.0,
                child: const Center(
                  // child: BlurHash(
                  //   imageFit: BoxFit.cover,
                  //   duration: const Duration(seconds: 4),
                  //   curve: Curves.bounceInOut,
                  //   hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                  //   image: image,
                  // ),
                ));
          }
        }, errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: kgrey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: size ?? 100.0,
            height: size ?? 100.0,
            child: const Center(
              child: Icon(
                Icons.error,
                color: kwhiteColor,
                size: 30.0,
              ),
            ),
          );
        }),
      ),
    );
  }
}