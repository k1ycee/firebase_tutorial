 import 'package:flutter/widgets.dart';

Widget button(
    {Color? textColor,
    String? text,
    Color? buttonColor,
    double? height,
    double? width, @required VoidCallback? onPressed}) {
  return GestureDetector(
    onTap: onPressed!,
      child: Container(
      height: height!,
      width: width!,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: buttonColor!),
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
              color: textColor!, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}

Widget fakeButton(
    {Color? textColor,
    String? text,
    Color? buttonColor,
    double? height,
    double? width}) {
  return Container(
  height: height!,
  width: width!,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50), color: buttonColor!),
  child: Center(
    child: Text(
      text!,
      style: TextStyle(
          color: textColor!, fontSize: 14, fontWeight: FontWeight.w500),
    ),
  ),
    );
}