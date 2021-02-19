import 'package:flutter/material.dart';
import 'package:get_active_prf/data/percentage_logic.dart';
import 'package:get_active_prf/models/progress.dart';
import 'package:get_active_prf/screens/DayScreen.dart';
import 'package:get_active_prf/screens/explore.dart';
import 'package:get_active_prf/screens/log_in.dart';
import 'package:get_active_prf/screens/register.dart';
import 'package:get_active_prf/screens/vid_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Assign widget based on availability of currentUser

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  DatabaseService db = DatabaseService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = StreamProvider<UserProgress>.value(
        // All children will have access to SuperHero data
        value: db.getUerProgress(firebaseUser.uid),
        child: Explore(),
      );
    } else {
      firstWidget = LogIn();
    }
    return MultiProvider(
      providers: [
        StreamProvider<UserProgress>.value(
            value: db.getUerProgress(firebaseUser.uid)),
        StreamProvider<int>.value(value: db.setnoofweeks(firebaseUser.uid)),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.black,
            platform: TargetPlatform.iOS,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
            })),
        debugShowCheckedModeBanner: false,
        home: firstWidget,
        routes: {
          '/log_n': (context) => LogIn(),
          '/Register': (context) => Register(),
          '/Explore': (context) => StreamProvider<UserProgress>.value(
                // All children will have access to SuperHero data
                value: db.getUerProgress(firebaseUser.uid),
                child: Explore(),
              ),
          '/VidScreen': (context) => VidScreen(),
          '/dayscreen': (context) => DayScreen(),
        },
      ),
    );
  }
}
