import 'package:firebase_auth/firebase_auth.dart' as au;

import 'package:get_active_prf/models/user.dart';

class AuthService {
  final au.FirebaseAuth _auth = au.FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(au.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }
}
