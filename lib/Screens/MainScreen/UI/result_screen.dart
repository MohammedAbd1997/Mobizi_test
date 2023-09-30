import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twnty2/CustomWidget/LoaderWidget.dart';
import 'package:twnty2/CustomWidget/custom_text.dart';

import '../../../Utils/constant.dart';
import '../Cubit/main_cubit.dart';
import '../Cubit/main_states.dart';

class ResultScreen extends StatefulWidget {
  MainCubit? mainCubit;

  ResultScreen({this.mainCubit});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final myCubit = MainCubit();

  @override
  void initState() {
    // TODO: implement initState
    myCubit.getAllUsersFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => myCubit,
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (_, state) {
          log(state.toString());
        },
        builder: (cnx, state) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: mainAppColor,
            leading: IconButton(
              onPressed: () {
                myCubit.getAllUsersFromFirebase();
              },
              icon: const Icon(Icons.refresh),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: CustomText(
                    'Rest Exam',
                    fontSize: 18.sp,
                    color: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                      widget.mainCubit!.getQuestionsFromFirebase();
                    },
                  ),
                ),
              )
            ],
          ),
          body: myCubit.appUser == null
              ? LoaderWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomText(
                        "Your result is ${myCubit.appUser!.result}",
                        fontSize: 25.sp,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        itemBuilder: (_, i) => Card(
                          elevation: 5,
                          color: widget
                                      .mainCubit!
                                      .questions[i]
                                      .choice![widget.mainCubit!.questions[i]
                                          .selectedAnswer]
                                      .toString() ==
                                  widget.mainCubit!.questions[i].answer
                                      .toString()
                              ? Colors.green
                              : Colors.red,
                          child: ListTile(
                            title: CustomText(
                              "${widget.mainCubit!.questions[i].name}",
                              fontSize: 17.sp,
                            ),
                            trailing: CustomText(
                              'Correct answer : ${widget.mainCubit!.questions[i].answer}',
                              fontSize: 19.sp,
                            ),
                          ),
                        ),
                        separatorBuilder: (_, i) => SizedBox(
                          height: 30,
                        ),
                        itemCount: widget.mainCubit!.questions.length,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomText(
                        "leaderboard",
                        fontSize: 25.sp,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        itemBuilder: (_, i) => Card(
                          elevation: 5,
                          child: ListTile(
                            title: CustomText(
                              "${myCubit.allUsers[i].name}",
                              fontSize: 17.sp,
                            ),
                            trailing: CustomText(
                              'result : ${myCubit.allUsers[i].result}',
                              fontSize: 19.sp,
                            ),
                          ),
                        ),
                        separatorBuilder: (_, i) => SizedBox(
                          height: 30,
                        ),
                        itemCount: myCubit.allUsers.length,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
