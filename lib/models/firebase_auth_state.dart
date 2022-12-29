import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/repo/user_network_repository.dart';
import 'package:path/path.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _firebaseUser;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context, @required String email,
      @required String password) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";

      switch (error.code) {
        case 'email-already-in-use':
          _message = "이메일 이미있음!";
          break;
        case 'invalid-email':
          _message = "이메일 이상해";
          break;
        case 'operation-not-allowed':
          _message = "뭔가 안돼";
          break;
        case 'weak-password':
          _message = "비번 부실";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text("Please try again later!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      //todo send data to firestore
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser?.uid, email: _firebaseUser!.email.toString());
    }
  }

  void logIn(context, @required String email, @required String password) {
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";

      switch (error.code) {
        case 'invalid-email':
          _message = "이메일 다름!";
          break;
        case 'user-disabled':
          _message = "유저 금지";
          break;
        case 'user-not-found':
          _message = "유저 안보임";
          break;
        case 'wrong-password':
          _message = "비번 틀림";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  User? get firebaseUser => _firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
