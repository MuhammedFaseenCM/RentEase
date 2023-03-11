import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentease/view/core/string_consts.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final bool camIcon;
  final dynamic imageFunction;
  final String imageText;
  final double? height;
  final double? width;
  const ImageWidget(
      {super.key,
      required this.image,
      this.camIcon = true,
      this.imageFunction,
      required this.imageText,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        ImageContainer(
            pic: image, imageText: imageText, height: height, width: width),
        camIcon
            ? const SizedBox()
            : Positioned(
                child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) =>
                        BottomSheetWidget(imageFunction: imageFunction)),
                  );
                },
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ))
      ]),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final dynamic imageFunction;
  final bool isMultiImage;
  const BottomSheetWidget({super.key, this.imageFunction, this.isMultiImage=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            StringConsts.chooseText,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  imageFunction.pickImage(
                      source: ImageSource.gallery, context: context);
                },
                icon: const Icon(Icons.image),
                label: const Text(StringConsts.galleryText),
              ),
              TextButton.icon(
                onPressed: () {
                  imageFunction.pickImage(
                      source: ImageSource.camera, context: context);
                },
                icon: const Icon(Icons.camera),
                label: const Text(StringConsts.cameraText),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String pic;
  final double? height;
  final double? width;
  final String imageText;
  const ImageContainer(
      {super.key,
      required this.pic,
      this.height,
      this.width,
      required this.imageText});

  @override
  Widget build(BuildContext context) {
    return pic == ''
        ? Container(
            height: height ?? 360,
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload),
                  Text(imageText),
                ],
              ),
            ),
          )
        : Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(pic),
                ),
              ),
            ),
          );
  }
}
