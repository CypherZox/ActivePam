import 'package:flutter/material.dart';
import 'package:get_active_prf/data/percentage_logic.dart';
import 'package:get_active_prf/screens/choose_version.dart';
import 'package:get_active_prf/screens/DayScreen.dart';
import 'package:get_active_prf/screens/done_screen.dart';
import 'package:get_active_prf/screens/explore.dart';
import 'package:get_active_prf/screens/jussst.dart';
import 'package:get_active_prf/screens/log_in.dart';
import 'package:get_active_prf/screens/register.dart';
import 'package:get_active_prf/screens/start_workout.dart';
import 'package:get_active_prf/screens/test.dart';
import 'package:get_active_prf/screens/testest.dart';
import 'package:get_active_prf/screens/vid_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => PrcntgLogic(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          platform: TargetPlatform.iOS,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
          })),
      debugShowCheckedModeBanner: false,
      initialRoute: '/Explore',
      routes: {
        '/log_n': (context) => LogIn(),
        '/Register': (context) => Register(),
        '/Explore': (context) => Explore(),
        '/Choose_version': (context) => ChooseVersion(),
        '/StartWorkout': (context) => StartWorkout(),
        '/VidScreen': (context) => VidScreen(),
        '/DoneScreen': (context) => Done(),
        '/testScreen': (context) => TestScreen(),
        '/just': (context) => JustAtest(),
        '/jusst': (context) => Jusst(),
        '/dayscreen': (context) => DayScreen(),
      },
    );
  }
}
