
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/constant.dart';

class CustomBotton extends StatelessWidget {
  VoidCallback? onTap;
  double? height;
  double? width;
  Color? backgroundColor;
  Color? borderColor;
  String? title;
  TextStyle? style;
  double? borderRadius;
  EdgeInsetsGeometry? margin;
  bool? isloading;

  CustomBotton(
      {this.onTap,
      this.height = 50,
      this.width = double.infinity,
      this.margin,
      this.backgroundColor = mainAppColor,
      this.title,
      this.style,
      this.isloading = false,
      this.borderColor = Colors.transparent,
      this.borderRadius = 5});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        alignment: Alignment.center,
        height: height!.h,
        width: width!.w,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor!, width: 1),
            borderRadius: BorderRadius.circular(borderRadius!)),
        child: isloading!
            ? Container(
                width: height!.h,
                height: height!.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                title!,
                style: style ??
                    TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
              ),
      ),
    );
  }
}
