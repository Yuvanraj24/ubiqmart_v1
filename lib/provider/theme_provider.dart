import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../values/color.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.green,

      // unselectedIconTheme: IconThemeData(color: Colors.white),
      // unselectedItemColor: Colors.white,
      // unselectedLabelStyle: TextStyle(color: Colors.white)
    ),
    listTileTheme: const ListTileThemeData(tileColor: Colors.blueGrey),
    // textTheme: const TextTheme(
    //   // titleSmall: TextStyle(fontSize: 10.0),
    // titleMedium: TextStyle(color: MyColors.black),
    // ),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.lightBlue100,
    primaryColor: MyColors.lightBlue100,
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(color: MyColors.lightBlue),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.orange,

      unselectedIconTheme: IconThemeData(color: Colors.black),
      unselectedItemColor: Colors.black,
      // unselectedLabelStyle: TextStyle(color: Colors.white)
    ),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor: Colors.white,
    //   selectedItemColor: Colors.bal,
    // ),
    // textTheme:  TextTheme(
    //   headline6:  const TextStyle(fontSize: 20.0),
    //   titleMedium: const  TextStyle(fontSize: 20.0),
    // ),
    iconTheme: const IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
