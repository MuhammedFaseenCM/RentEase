import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final double? width;
  final Function(BuildContext) onpressed;
  const ButtonWidget(
      {super.key,
      required this.text,
      this.color,
      required this.onpressed,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50.0,
      decoration: BoxDecoration(
          color: color ?? Colors.orange[900],
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
                color: color ?? Colors.orange[200]!,
                blurRadius: 30,
                offset: const Offset(10, 10))
          ]),
      child: TextButton(
        onPressed: (() => onpressed(context)),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
