import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/auth/auth_screen.dart';
import 'package:insta_two/constants/material_white.dart';
import 'package:insta_two/home_page.dart';
import 'package:insta_two/models/firebase_auth_state.dart';
import 'package:insta_two/models/user_model_state.dart';
import 'package:insta_two/repo/user_network_repository.dart';
import 'package:insta_two/widget/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  Widget? _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState,
              Widget child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _currentWidget = HomePage();
                break;
              default:
                _currentWidget = MyProgressIndicator();
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _currentWidget,
            );
          },
        ),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }
}
