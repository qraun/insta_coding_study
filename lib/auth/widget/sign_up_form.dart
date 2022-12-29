import 'package:flutter/material.dart';
import 'package:insta_two/constants/auth_input_decor.dart';
import 'package:insta_two/auth/widget/or_divider.dart';
import 'package:insta_two/constants/common_size.dart';
import 'package:insta_two/home_page.dart';
import 'package:insta_two/models/firebase_auth_state.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: common_l_gap),
              Image.asset("assets/images/insta_text_logo.png"),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _emailController,
                decoration: textInputDecor("Email"),
                validator: (text) {
                  if (text!.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세요.';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                obscureText: true,
                //비밀번호 가리기
                cursorColor: Colors.black54,
                controller: _pwController,
                decoration: textInputDecor("Password"),
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 3) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호를 입력해주세요.';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                obscureText: true,
                //비밀번호 가리기
                cursorColor: Colors.black54,
                controller: _cpwController,
                decoration: textInputDecor("Confirm Password"),
                validator: (text) {
                  if (text!.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return '비밀번호와 일치하지 않습니다.';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              TextButton.icon(
                onPressed: () {
                  Provider.of<FirebaseAuthState>(context, listen: false)
                      .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Text Color
                ),
                icon: ImageIcon(AssetImage("assets/images/facebook.png")),
                label: Text("Login with Facebook"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          print("validation success!!!"); //현재 화면 없애고 다음화면으로 대체
          Provider.of<FirebaseAuthState>(context, listen: false)
              .registerUser(context, _emailController.text, _pwController.text,);
        }
      },
      style: TextButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        "Join With",
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  }





