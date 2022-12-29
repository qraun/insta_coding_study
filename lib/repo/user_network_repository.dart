import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_two/constants/firestore_keys.dart';
import 'package:insta_two/models/firestore/user_model.dart';
import 'package:insta_two/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attemptCreateUser({String? userKey, required String email}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    
    DocumentSnapshot snapshot = await userRef.get();
    if(!snapshot.exists){
      return await userRef.set(UserModel.getMapForCreateUser(email));
    }
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
