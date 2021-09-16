//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  accentColor: defaultAccentColor,
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: defaultColor,
    //   statusBarIconBrightness: Brightness.light,
    // ),
    iconTheme: IconThemeData(
      size: 20.0,
      color: Colors.grey,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Aladin',
      color: defaultColor,
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
    ),
    titleSpacing: 20.0,
    actionsIconTheme: IconThemeData(
      color: Colors.black45,
      size: 20.0,
    ),
  ),
  // textTheme: TextTheme(
  //   bodyText1: TextStyle(
  //     fontWeight: FontWeight.w600,
  //     color: Colors.black,
  //     fontSize: 18.0,
  //   ),
  //   bodyText2: TextStyle(
  //     fontWeight: FontWeight.w400,
  //     color: Colors.black45,
  //     fontSize: 16.0,
  //   ),
  //   subtitle1: TextStyle(
  //     fontWeight: FontWeight.w600,
  //     color: Colors.black45,
  //     fontSize: 18.0,
  //     height: 1.4,
  //   ),
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.black26,
    selectedLabelStyle: TextStyle(fontFamily: 'Aladin'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Aladin')
  ),
  // fontFamily: 'Aladin',
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade800,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultAccentColor,
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: Colors.black26,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      size: 20.0,
      color: Colors.blueGrey,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Aladin',
      color: Colors.grey.shade600,
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
    ),
    titleSpacing: 0.0,
    actionsIconTheme: IconThemeData(
      color: Colors.grey.shade600,
      size: 20.0,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 22.0,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 16.0,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 14.0,
      height: 1.4,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black38,
      fontSize: 18.0,
      height: 1.4,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    backgroundColor: Colors.black26,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.black12,
  ),
  fontFamily: 'Aladin',
);
