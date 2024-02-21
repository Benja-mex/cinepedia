import 'package:flutter/material.dart';

//const MaterialColor _customColor = Color(0xff5c11d4);
const List<MaterialColor> colorThemes = [
  // _customColor,
  Colors.amber,
  Colors.blue,
  Colors.blueGrey,
  Colors.brown,
  Colors.cyan,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.green,
  Colors.grey,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
];

class AppTheme {
  final int selectTheme;
  AppTheme({this.selectTheme = 0})
      : assert(
          selectTheme >= 0 && selectTheme <= colorThemes.length - 1,
          'Theme fuera de rango debe ser entre 0 y ${colorThemes.length - 1}',
        );
  ThemeData getTheme() {
    return ThemeData(
        inputDecorationTheme:
            InputDecorationTheme(fillColor: colorThemes[selectTheme][100]),
        useMaterial3: true,
        colorSchemeSeed: colorThemes[selectTheme],
        //ColorScheme.fromSwatch(primarySwatch: _colorThemes[selectTheme], brightness: Brightness.light),
        scaffoldBackgroundColor: colorThemes[selectTheme][100],
        appBarTheme: AppBarTheme(
            centerTitle: true, backgroundColor: colorThemes[selectTheme][300]),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorThemes[selectTheme][300],
            elevation: 0,
            selectedIconTheme:
                IconThemeData(color: colorThemes[selectTheme][700]),
            selectedLabelStyle: TextStyle(
                color: colorThemes[selectTheme][700],
                fontWeight: FontWeight.w600),
            selectedItemColor: colorThemes[selectTheme][100],
            unselectedItemColor: colorThemes[selectTheme][100]),
        tabBarTheme: TabBarTheme(
            indicatorColor: colorThemes[selectTheme][700],
            labelColor: colorThemes[selectTheme][100],
            tabAlignment: TabAlignment.center),
        cardTheme:
            CardTheme(elevation: 0, color: colorThemes[selectTheme][400]));
  }
}
