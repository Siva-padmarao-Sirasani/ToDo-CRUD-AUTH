import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> googleSignIn() async {
    try {
      GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: _googleSignInAuthentication.idToken,
            accessToken: _googleSignInAuthentication.accessToken);

        UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
