import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twnty2/CustomWidget/custom_button.dart';
import 'package:twnty2/CustomWidget/custom_text.dart';
import 'package:twnty2/Helper/Model/question.dart';
import 'package:twnty2/Screens/MainScreen/Cubit/main_states.dart';
import 'package:twnty2/Screens/MainScreen/UI/widgets/choice_widget.dart';

import '../../Cubit/main_cubit.dart';

class QuestionWidget extends StatelessWidget {
  Question? question;
  MainCubit? mainCubit;

  QuestionWidget({Key? key, this.question, this.mainCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          CustomText(
            'Question ${mainCubit!.selectedQuestion + 1}',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            '${question!.name}',
            color: Colors.black,
            fontSize: 46.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 30.h,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) => ChoiceWidget(
                    question: question,
                    i: i,
                    mainCubit: mainCubit,
                  ),
              separatorBuilder: (_, i) => SizedBox(
                    height: 15.h,
                  ),
              itemCount: question!.choice!.length),
          SizedBox(
            height: 30.h,
          ),
          CustomBotton(
            title:
                mainCubit!.selectedQuestion == mainCubit!.questions.length - 1
                    ? "Finish"
                    : "Next",
            onTap: () {
              mainCubit!.goToNextQuestion(mainCubit!);
            },
            backgroundColor: question!.selectedAnswer == -1
                ? Colors.grey
                : Colors.blueAccent,
            isloading: mainCubit!.isLoading,
          ),
          SizedBox(
            height: 130.h,
          ),
        ],
      ),
    );
  }
}
