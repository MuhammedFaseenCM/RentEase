import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class ItemContainer extends StatelessWidget {
  final String image;
  final String? title;
  final String? perday;
  final String? location;
  const ItemContainer(
      {super.key,
      required this.image,
      required this.title,
      required this.perday,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 210,
          width: 180,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: GridTile(
            footer: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              child: GridTileBar(
                backgroundColor: kwhiteColor,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rs.$perday/day",
                        style: const TextStyle(
                          color: kblackColor,
                        )),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: kblackColor,
                        ),
                        Text("$location",
                            style: const TextStyle(
                              color: kblackColor,
                            )),
                      ],
                    ),
                  ],
                ),
                title: Text(
                  title!,
                  style: const TextStyle(
                      color: kblackColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
