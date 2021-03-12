import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  static Stream<User> get firebaseUserStream {
    return _auth.authStateChanges();
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } catch (error) {
      print(error.message);
    }

    // Return null to prevent further exceptions if googleSignInAccount is null
    if (googleUser == null) return null;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  static Future<UserCredential> signUpEmail(
      {@required String email, @required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> signInEmail(
      {@required String email, @required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
