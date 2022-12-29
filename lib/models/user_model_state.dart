import 'package:flutter/foundation.dart';
import 'package:insta_two/models/firestore/user_model.dart';

class UserModelState extends ChangeNotifier{
  late UserModel _userModel;

  UserModel get userModel=> _userModel;

  set userModel (UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}