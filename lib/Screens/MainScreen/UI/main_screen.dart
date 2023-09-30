import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twnty2/CustomWidget/LoaderWidget.dart';
import 'package:twnty2/Helper/Router/router.dart';
import 'package:twnty2/Helper/SharedPreferance/shared_preferance.dart';
import 'package:twnty2/Screens/AuthScreen/UI/auth_screen.dart';
import 'package:twnty2/Screens/MainScreen/UI/widgets/question_widget.dart';

import '../../../Utils/constant.dart';
import '../Cubit/main_cubit.dart';
import '../Cubit/main_states.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final myCubit = MainCubit();

  @override
  void initState() {
    // TODO: implement initState
    myCubit.getQuestionsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => myCubit,
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (cnx, state) {},
        builder: (cnx, state) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: mainAppColor,
              leading: IconButton(
                onPressed: () {
                  myCubit.getQuestionsFromFirebase();
                },
                icon: const Icon(Icons.refresh),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    SpHelper.spHelper.setTokenId("");
                    RouterHelper.routerHelper
                        .routingReplacementUntil(AuthScreen());
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: MainCubit.get(cnx).selectedQuestion == -1 ||
                    MainCubit.get(cnx).isLoadingQuestion
                ? LoaderWidget()
                : QuestionWidget(
                    question: MainCubit.get(cnx)
                        .questions[MainCubit.get(cnx).selectedQuestion],
                    mainCubit: myCubit,
                  )),
      ),
    );
  }
}
