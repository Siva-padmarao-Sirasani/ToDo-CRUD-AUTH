import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo/Screens/HomeScreen.dart';
import 'package:todo/Screens/SignUp.dart';

import '../FirebaseAuthentication/firebaseAuth.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
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
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20, color:Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height:60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,

                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0,),

                      SvgPicture.asset(
                        'assets/images/google.svg',
                        width: 30,
                        height: 30, // Set the desired height here

                      ),
                      SizedBox(width: 20),
                      Text('Continue with Google'),
                      SizedBox(height: 15.0,),


                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  height:60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,

                  ),

                  child: Row(
                    children: [
                      SizedBox(width: 10.0,),
                      Icon(Icons.phone,size: 30.0,color: Colors.black,),
                      SizedBox(width: 20),
                      Text('Continue with Phone'),
                      SizedBox(height: 15.0,),


                    ],
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
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
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
                  onPressed:SignIn,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text('SignIn'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('do not have an account? ',style: TextStyle(color: Colors.white),),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context)=>SignUp()),
                        );
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle forgot password logic
                  },
                  child: Text('Forgot Password?',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void SignIn() async{
    try {
      String email=emailController.text;
      String password=passwordController.text;
      User? user=await _auth.signInWithEmailAndPassword(email, password);
      if(user!=null) {
        // print("successful login");
        Get.offAll(()=>HomeScreen());
      }
    }
    catch(e){
      print(e);
    }
  }
}
