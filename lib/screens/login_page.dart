import 'package:app_second/asset/pallete.dart';
import 'package:app_second/screens/registar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_page.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      // Login successful, handle navigation or other logic here
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "User Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade300,
            textColor: Colors.black,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade300,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
            "https://img.freepik.com/free-vector/blue-fluid-background-frame_53876-99019.jpg"),
      )),
      child: Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: Stack(
          children: [
            Container(
              child: const Padding(
                padding: const EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Pallete.mainFontColor,
                      fontFamily: 'Cera Pro'),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: 35,
                      right: 35),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        // width: 20,
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      // Text(
                      //   'Sign',
                      //   style: TextStyle(
                      //       fontSize: 27,
                      //       fontWeight: FontWeight.w700,
                      //       fontFamily: 'Cera Pro',
                      //       color: Pallete.blackColor),
                      // ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            _login();
                          },
                          child: Ink(
                            color: Colors.blue.shade400,
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(Icons
                                      .email), // <-- Use 'Image.asset(...)' here
                                  SizedBox(width: 12),
                                  Text(
                                    'Sign in with Email',
                                    style: TextStyle(color: Pallete.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyResgistar(),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(color: Colors.black),
                              // style: kHaveAnAccountStyle(size),
                              children: [
                                TextSpan(
                                  text: " Login",
                                  style: TextStyle(color: Colors.blue),
                                )
                                //  style: kLoginOrSignUpTextStyle(size)),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
