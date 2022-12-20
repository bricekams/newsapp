import 'package:flutter/material.dart';


extension MaterialStateSheet on Set<MaterialState> {
  bool get isSelected => contains(MaterialState.selected);

  bool get isHover => contains(MaterialState.hovered);

  bool get isFocus => contains(MaterialState.focused);

  bool get isPressed => contains(MaterialState.pressed);
}

class AppTheme {

  /// Colors Scheme
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;
  static final Color _primary = Colors.blue.shade900;
  static final Color _scaffoldBgLight = Colors.grey[50]!;
  static final Color _scaffoldBgDark = Colors.grey[800]!;

  static ThemeData light = ThemeData(
    primaryColor: _primary,
    appBarTheme: AppBarTheme(
      backgroundColor: _primary
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: _primary,
      backgroundColor: _scaffoldBgLight,
      labelTextStyle: MaterialStateProperty.resolveWith((states)=>const TextStyle(fontWeight: FontWeight.bold,fontSize: 12)) ,
      iconTheme: MaterialStateProperty.resolveWith((states){
        if(states.isSelected){
          return const IconThemeData(color: _white);
        }
        return const IconThemeData(color: _black);
      }),
    )
  );
  static ThemeData dark = ThemeData(
      primaryColor: _primary,
      appBarTheme: AppBarTheme(
          backgroundColor: _primary
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: _primary,
        backgroundColor: _scaffoldBgDark,
        labelTextStyle: MaterialStateProperty.resolveWith((states)=>const TextStyle(fontWeight: FontWeight.bold,fontSize: 12)) ,
        iconTheme: MaterialStateProperty.resolveWith((states){
          if(states.isSelected){
            return IconThemeData(color: _scaffoldBgDark);
          }
          return IconThemeData(color: _scaffoldBgLight);
        }),
      )
  );
}