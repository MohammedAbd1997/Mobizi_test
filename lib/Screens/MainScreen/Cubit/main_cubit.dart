import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twnty2/Helper/Model/app_user.dart';
import 'package:twnty2/Helper/Model/question.dart';
import 'package:twnty2/Helper/Notifications/notification_helper.dart';
import 'package:twnty2/Helper/Router/router.dart';
import 'package:twnty2/Helper/SharedPreferance/shared_preferance.dart';

import '../UI/result_screen.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  AppUser? appUser;

  List<Question> questions = [];
  List<AppUser> allUsers = [];

  int selectedQuestion = -1;

  int resultOfUser = 0;

  final fireStore = FirebaseFirestore.instance;

  bool isLoading = false;

  /// loading for button screen
  bool isLoadingQuestion = false;

  /// loading for main screen

  /// change status when choose answer
  ///
  changeQuestionAnswer(int i, Question question) {
    question.selectedAnswer = i;
    emit(MainLoading());
  }

  /// to move to next question and calc result
  goToNextQuestion(MainCubit mainCubit) async {
    if (questions[selectedQuestion].selectedAnswer != -1) {
      if (questions[selectedQuestion].answer ==
          questions[selectedQuestion]
              .choice![questions[selectedQuestion].selectedAnswer]) {
        resultOfUser++;
      }

      if (selectedQuestion == questions.length - 1) {
        await updateResultUser();
        NotificationHelper.notificationHelper
            .sendPushNotification("youe result in exam is : ${resultOfUser}");
        RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
            ResultScreen(mainCubit: mainCubit));
      } else {
        selectedQuestion++;
      }
    }

    emit(MainLoading());
  }

  /// get all question from firebase
  getQuestionsFromFirebase() async {
    isLoadingQuestion = true;

    /// to show loading
    emit(MainLoading());

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fireStore.collection("Questions").get();
    questions.clear();
    selectedQuestion = -1;
    for (var b in querySnapshot.docs) {
      Question question = Question.fromMap(b.data());
      question.id = b.id;
      questions.add(question);

      /// to fill question array
    }
    if (questions.isNotEmpty) {
      selectedQuestion = 0;
    }
    resultOfUser = 0;

    isLoadingQuestion = false;

    /// to hide loading
    emit(MainLoading());
  }

  /// when exam finish store result in firebase
  updateResultUser() async {
    isLoading = true;
    emit(MainLoading());
    await fireStore
        .collection('Users')
        .doc(SpHelper.spHelper.getTokenId())
        .update({'result': resultOfUser.toString()});
    isLoading = false;
    emit(MainLoading());
  }

  /// get All user From firebase leaderBoard to show who is first
  getAllUsersFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
        .collection('Users')
        .orderBy("result", descending: true)
        .get();
    allUsers.clear();
    for (var b in querySnapshot.docs) {
      AppUser appUser = AppUser.fromMap(b.data());
      appUser.userId = b.id;
      allUsers.add(appUser);
      if (appUser.userId == SpHelper.spHelper.getTokenId().toString()) {
        this.appUser = appUser;
      }
    }
    emit(MainLoading());
  }
}
