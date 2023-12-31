import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthServices {
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } catch (e) {
      print("Error signing in: $e");
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } catch (e) {
      print("Error signing up: $e");
    }
    return null;
  }
  Future<void> signUpWithPhoneNumber(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (FirebaseAuth.AuthCredential credential) async {
          FirebaseAuth.UserCredential res = await _auth.signInWithCredential(credential);
          print("Phone authentication completed. User: ${res.user?.uid}");
        },
        verificationFailed: (FirebaseAuth.FirebaseAuthException e) {
          print("Verification failed: $e");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle the code sent, if needed
          print("Verification code sent to $phoneNo");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle the code auto-retrieval timeout, if needed
          print("Code auto-retrieval timed out");
        },
      );
    } catch (e) {
      print("Error signing in with phone number: $e");
    }
  }

}
