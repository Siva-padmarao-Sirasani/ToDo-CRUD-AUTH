import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/Screens/OtpScreen.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = TextEditingController();
  late String verificationId; // Declare the verificationId variable

  void signUpWithPhoneNumber() async {
    String phoneNumber = '+91' + phoneNumberController.text.trim();
    print(phoneNumber);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        print("Verification completed, signed in: ${_auth.currentUser?.uid}");

        // Navigate to the OTP screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId: ''),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verificationId
        this.verificationId = verificationId;

        // Navigate to the OTP screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                prefixText: '+91 ',
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUpWithPhoneNumber,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
