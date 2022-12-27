import 'package:flutter/material.dart';

extension MaterialStateSheet on Set<MaterialState> {
  bool get isSelected => contains(MaterialState.selected);

  bool get isHover => contains(MaterialState.hovered);

  bool get isFocus => contains(MaterialState.focused);

  bool get isPressed => contains(MaterialState.pressed);
}

class AppTheme {
  static const Color _black = Colors.black;
  static final Color _primaryLight = Colors.blue.shade900;
  static final Color _primaryDark = Colors.tealAccent.shade700;
  static final Color _scaffoldBgLight = Colors.grey[50]!;
  static final Color _scaffoldBgDark = Colors.grey[800]!;

  static ThemeData light = ThemeData(
      primaryColor: _primaryLight,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(backgroundColor: _primaryLight),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: _primaryLight,
        backgroundColor: _scaffoldBgLight,
        labelTextStyle: MaterialStateProperty.resolveWith((states) =>
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.isSelected) {
            return IconThemeData(color: _scaffoldBgLight);
          }
          return const IconThemeData(color: _black);
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryLight,
      ),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
              (states) => states.isSelected ? Colors.blue.shade600 : null),
          thumbColor: MaterialStateProperty.resolveWith(
              (states) => states.isSelected ? _primaryLight : null)),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: _primaryLight));
  static ThemeData dark = ThemeData(
    primaryColor: _primaryDark,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _scaffoldBgDark,
    appBarTheme: AppBarTheme(backgroundColor: _primaryDark),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
          (states) => states.isSelected ? _primaryDark : null),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: _primaryDark,
      backgroundColor: _scaffoldBgDark,
      labelTextStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: states.isSelected ? _primaryDark : null)),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.isSelected) {
          return IconThemeData(color: _scaffoldBgDark);
        }
        return IconThemeData(color: _scaffoldBgLight);
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: _primaryDark),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade300,
    ),
  );
}
