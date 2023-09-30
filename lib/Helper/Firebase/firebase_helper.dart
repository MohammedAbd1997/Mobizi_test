import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);

  final FirebaseAuth _auth = FirebaseAuth.instance;



  /// sign in with google firebase side
  googleSignIn() async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    await _auth.signInWithCredential(credential);

    if (googleSignInAuthentication == null) {
      return;
    }
    return googleSignInAuthentication;
  }


}
