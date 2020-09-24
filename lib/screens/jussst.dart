import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get_active_prf/data/percentage_logic.dart';

class Jusst extends StatefulWidget {
  @override
  _JusstState createState() => _JusstState();
}

class _JusstState extends State<Jusst> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User get user {
    return auth.currentUser;
  }

  String get name {
    return user.displayName;
  }

  Future updateUserName(String name, User currentUser) async {
    currentUser.updateProfile(
      displayName: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final prcntgeProvider = Provider.of<PrcntgLogic>(context, listen: true);
    return Container(child: Text('$name'));
  }
}
