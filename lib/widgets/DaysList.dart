import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/widgets/new_day_tile.dart';

// import 'package:provider/provider.dart';
// import 'package:get_active_prf/data/percentage_logic.dart';

class VidsListView extends StatefulWidget {
  final String title;
  final String version;
  final List vidIds;
  VidsListView({this.title, this.version, this.vidIds});
  @override
  _VidsListViewState createState() => _VidsListViewState();
}

class _VidsListViewState extends State<VidsListView> {
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
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffDEDEDE),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 7.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final id = widget.vidIds[index];
                  return NewDayTile(
                    vidID: id,
                  );
                },
                itemCount: widget.vidIds.length,
              ),
            )
          ]),
        ));
  }
}
