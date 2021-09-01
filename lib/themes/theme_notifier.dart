import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/themes/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: Color(0xff121212),
        onPrimary: const Color(0xff1F1B24),
        primaryVariant: const Color(0xfff4f4f4),
        secondary: const Color(0xfff0a500),
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
      }));

  final lightTheme = ThemeData(
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.black,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: const Color(0xfff4f4f4),
        onPrimary: const Color(0xffDEDEDE),
        primaryVariant: Color(0xff121212),
        secondary: const Color(0xfff0a500),
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
      }));

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void toggleMode() async {
    _themeData == darkTheme ? _themeData = lightTheme : _themeData = darkTheme;

    notifyListeners();
  }
}
