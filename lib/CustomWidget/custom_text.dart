import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLines;
  Color? color;
  double? height;
  VoidCallback? onTap;
  TextDecoration? decoration;

  CustomText(this.text,
      {this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.color = Colors.black,
      this.height,
      this.onTap,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
            decoration: decoration ?? TextDecoration.none,
            color: color,
            height: height,
            fontSize: fontSize ?? 14.sp,
            overflow: maxLines == null ? null : TextOverflow.ellipsis,
            fontWeight: fontWeight ?? FontWeight.w400),
        textAlign: textAlign ?? TextAlign.start,
      ),
    );
  }
}
