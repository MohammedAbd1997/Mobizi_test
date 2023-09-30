import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twnty2/Helper/Router/router.dart';

import '../../../Helper/Firebase/firebase_helper.dart';
import '../../../Helper/Model/app_user.dart';
import '../../../Helper/SharedPreferance/shared_preferance.dart';
import '../../MainScreen/UI/main_screen.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());


  /// credential User
  User? user;

  FirebaseAuth? auth = FirebaseAuth.instance;

  final fireStore = FirebaseFirestore.instance;

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;




  /// sign in with google
  signInWithGoogle() async {

    isLoading =true;
    emit(state);

    try {
      GoogleSignInAuthentication? googleSignInAuthentication =
          await FirebaseAuthHelper.firebaseAuthHelper.googleSignIn();

      if (googleSignInAuthentication != null) {
        user = auth!.currentUser!;
        if (user != null) {
          storeUserInFirebase(user!);
        }
        return googleSignInAuthentication;
      } else {
        return;
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading =true;
    emit(state);
  }


   /// store user in firebase if not exist first register
  storeUserInFirebase(User user) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    AppUser appUser = AppUser(
        imageUrl: user.photoURL,
        userId: user.uid,
        email: user.email,
        name: user.displayName,
        token: fcmToken);

    AppUser? us = await getUserFromFireStore(user.uid);
    if (us == null) {
      await addUserToFireStore(appUser);
    }

    SpHelper.spHelper.setTokenId(user.uid);
    RouterHelper.routerHelper.routingReplacementUntil( MainScreen());
  }



   /// add User to firebase User collection
  addUserToFireStore(AppUser appUser) async {
    try {
      await fireStore
          .collection('Users')
          .doc(appUser.userId)
          .set(appUser.toMap());
    } catch (e) {
      log(e.toString());
    }
  }


/// get User by id if exist
  getUserFromFireStore(String userId) async {
    if (userId != '') {
      DocumentSnapshot user =
          await fireStore.collection('Users').doc(userId).get();
      if (user.exists) {
        return AppUser.fromMap(user.data() as Map);
      } else {
        return;
      }
    }
  }
}
