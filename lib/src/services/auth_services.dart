// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_inkflow_app/src/res/helper_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final FacebookAuth facebookAuth = FacebookAuth.instance;

  String? _name;
  String? get name => _name;
  // loging in the user with email and password
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  // Future signInWithFacebook() async {
  //   final LoginResult result = await facebookAuth.login();
  //   // getting the profile
  //   if (result.status == LoginStatus.success) {
  //     try {
  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(result.accessToken!.token);
  //       await firebaseAuth.signInWithCredential(credential);
  //       return credential;
  //     } on FirebaseAuthException catch (e) {
  //       return e.message;
  //     }
  //   }
  // }

  // Sign in with google account
  signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    // obtain the data from request
    final GoogleSignInAuthentication gAuth = await guser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally signin with google account
    // final User userDetails =
    //     (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
    // _name = userDetails.displayName;
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
