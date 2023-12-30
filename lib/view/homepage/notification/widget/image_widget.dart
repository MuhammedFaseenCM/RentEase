import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class ReqImageWidget extends StatelessWidget {
  final String imageUrl;
  const ReqImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(imageUrl,
          height: 100.0,
          width: 120.0,
          fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Container(
              decoration: BoxDecoration(
                color: kgrey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: 120.0,
              height: 100.0,
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
      }, errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(
            color: kgrey,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: 120.0,
          height: 100.0,
          child: const Center(
            child: Icon(
              Icons.error,
              color: kwhiteColor,
              size: 30.0,
            ),
          ),
        );
      }),
    );
  }
}
