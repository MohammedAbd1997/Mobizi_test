import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twnty2/Helper/Model/question.dart';

import '../../Cubit/main_cubit.dart';
import '../../Cubit/main_states.dart';

class ChoiceWidget extends StatelessWidget {
  Question? question;
  int? i;
  MainCubit? mainCubit;

  ChoiceWidget({this.question, this.i, this.mainCubit});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        SizedBox(
          width: 30.r,
          height: 30.r,
          child: Radio(
            value: question!.selectedAnswer,
            groupValue: i,
            onChanged: (value) {
              mainCubit!.changeQuestionAnswer(i!, question!);
            },
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${question!.choice![i!]}',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        )
      ],
    );
  }
}
