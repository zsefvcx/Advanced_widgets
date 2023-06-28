import 'package:flutter/material.dart';

class AppStyleColor {
  final Color textColor;
  final Color appBarTextColor;
  final Color appBackgroundColor;
  final Color appBarBackgroundColor;
  final Color buttonBackgroundColor;
  final Color buttonIconColor;

  AppStyleColor({
    required this.textColor,
    required this.appBarTextColor,
    required this.appBackgroundColor,
    required this.appBarBackgroundColor,
    required this.buttonBackgroundColor,
    required this.buttonIconColor,
  });

}

class AppStyleTheme extends InheritedWidget{
  final AppStyleColor _appStyleColor;

  AppStyleColor get appStyleColor => _appStyleColor;

  AppStyleColor get appStyleInvertColor => AppStyleColor(
            appBackgroundColor: Color(~appStyleColor.appBackgroundColor.value),
            appBarBackgroundColor: Color(~appStyleColor.appBarBackgroundColor.value),
            appBarTextColor: Color(~appStyleColor.appBarTextColor.value),
            textColor: Color(~appStyleColor.textColor.value),
            buttonBackgroundColor: Color(~appStyleColor.buttonBackgroundColor.value),
            buttonIconColor: Color(~appStyleColor.buttonIconColor.value),
            );

  const AppStyleTheme({
    super.key,
    required super.child,
    required AppStyleColor appStyleColor,
  }) : _appStyleColor = appStyleColor;

  static AppStyleTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStyleTheme>() as AppStyleTheme;

  @override
  bool updateShouldNotify(AppStyleTheme oldWidget) => appStyleColor != oldWidget.appStyleColor;

}