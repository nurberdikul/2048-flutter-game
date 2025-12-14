import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int value;
  final double width;
  final double height;
  final Color color;
  final double fontSize;

  Tile(this.value, this.width, this.height, this.color, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: value != 0
          ? Text(
              '$value',
              style: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold),
            )
          : SizedBox(),
    );
  }
}