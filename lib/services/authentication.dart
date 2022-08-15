import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../shared/network/local/cache_helper.dart';

import '../shared/components/constants.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> signIn() async {
    try{
      UserCredential result = await _firebaseAuth.signInAnonymously();
      if(result.user!=null){
        userId=result.user!.uid;
        CacheHelper.saveData(key: 'userId', value: result.user!.uid);
      }else{
        throw 'Faild Authentication';
      }
    }catch(e){
      if (kDebugMode) {
        print('Error $e');
      }
      rethrow;
    }

  }
}

