import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class AuthRepository {

  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    /*
      /*
      if(...)
        map{username : Name
          password : passwd}
          toJSON
          db.update(map)
      else
        throw Exception('failed log in');
      */
      debugPrint('success');
      
      }
      catch(e)
      {
        debugPrint("failed login");
      }
    */
    return 'userID';
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String gender,
  }) async {
    print('signUp auth repo~~');
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'userID';
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}

