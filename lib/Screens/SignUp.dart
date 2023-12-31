import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo/FirebaseAuthentication/AuthService.dart';
import 'package:todo/Screens/HomeScreen.dart';
import 'package:todo/Screens/Phone.dart';
import 'package:todo/Screens/SignIn.dart';

import '../FirebaseAuthentication/firebaseAuth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _State();
}

class _State extends State<SignUp> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final AuthService authClass = AuthService();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff000509),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff7e8087),Color(0xff000509)])
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color:Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      User? user = await authClass.googleSignIn();
                      if (user != null) {
                        // User signed in with Google, navigate to home screen
                        Get.offAll(() => HomeScreen());
                      } else {
                        // Handle the case when Google Sign-In fails
                        print("Google Sign-In failed.");
                      }
                    },
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.0,),
                          SvgPicture.asset(
                            'assets/images/google.svg',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 20),
                          Text('Continue with Google'),
                          SizedBox(height: 15.0,),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15.0,),
                  Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhoneAuthPage()), // Replace 'PhoneScreen' with the actual name of your Phone screen class
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10.0,),
                          Icon(Icons.phone, size: 30.0, color: Colors.blue,),
                          SizedBox(width: 20.0,),
                          Text("Continue With Phone"),
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 20),
                  Text("Or",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(

                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // Toggle password visibility
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: SignUp,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ',style: TextStyle(color: Colors.white),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                            MaterialPageRoute(builder: (context)=>SignIn()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void SignUp() async{
    try {
      String? email=emailController.text;
      String? password=passwordController.text;
      User? user=await _auth.signUpWithEmailAndPassword(email, password);
      if(user!=null) {
        Get.offAll(()=>HomeScreen());
      }
    }
    catch(e){
      print(e);
    }
  }
}
