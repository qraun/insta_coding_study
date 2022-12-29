import 'package:flutter/material.dart';
import 'package:insta_two/auth/widget/sign_in_form.dart';
import 'package:insta_two/auth/widget/sign_up_form.dart';
import 'package:insta_two/profile/profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  List<Widget> forms = [
    SignUpForm(),
    SignInForm(),
  ];

  int selectedForm = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: selectedForm,
              children: forms,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 44,
              child: Container(
                color: Colors.white,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (selectedForm == 0) {
                          selectedForm = 1;
                        } else {
                          selectedForm = 0;
                        }
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                          text: (selectedForm == 0)
                              ? "Already have an account?  "
                              : "Don't have an account?  ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                                text:
                                    (selectedForm == 0) ? "Sign In" : "Sign Up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
