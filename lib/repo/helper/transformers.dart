import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_two/models/firestore/user_model.dart';

class Transformers{
  final dynamic toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
    handleData: (snapshot, sink) async{
      sink.add(UserModel.fromSnapshot(snapshot));
    }
  );
}