import 'package:app_second/screens/home_page.dart';
import 'package:app_second/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';
//import 'package:sign_in_button/sign_in_button.dart';

import '../asset/pallete.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MyResgistar extends StatefulWidget {
  const MyResgistar({super.key});

  @override
  State<MyResgistar> createState() => _MyResgistarState();
}

class _MyResgistarState extends State<MyResgistar> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool succes;
  late String userEmail;
  void register() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        succes = true;
        userEmail = user.email!;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      });
    } else {
      setState(() {
        succes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-vector/blue-fluid-background-frame_53876-99019.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: Stack(
          children: [
            Container(
              child: const Padding(
                padding: const EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Create\nAccount',
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
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        // onChanged: (String value) {
                        //   email = value;
                        // },
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
                        // onChanged: (String value) {
                        //   email = value;
                        // },
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
                      Center(
                        child: InkWell(
                          onTap: () {
                            _MyResgistarState();
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
                                    'Create Account',
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
                                builder: (context) => const MyLoginPage(),
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
    );
  }
}
