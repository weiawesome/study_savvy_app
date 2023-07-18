import 'package:flutter/material.dart';
import 'package:study_savvy_app/screens/note_taker.dart';

class AuthRepository {
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    try
    {
    /*if(...)
	map{username : Name
    password : passwd}
    toJSON
    db.update(map)
	else
		throw Exception('failed log in');
		*/
		debugPrint('success');
		check();
    }
    catch(e)
    {
      debugPrint("failed login");
    }
  }
}

bool check(){
	return true;
}