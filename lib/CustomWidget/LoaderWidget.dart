import 'package:flutter/material.dart';

import '../Utils/constant.dart';



class LoaderWidget extends StatelessWidget {
  Color? color;
  LoaderWidget({this.color =mainAppColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );
  }
}
