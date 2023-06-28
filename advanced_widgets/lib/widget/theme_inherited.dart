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
  final AppStyleColor _appStyleWhiteColor;

  AppStyleColor get appStyleColor => _appStyleColor;

  AppStyleColor get appStyleWhiteColor => _appStyleWhiteColor;

  const AppStyleTheme({
    super.key,
    required super.child,
    required AppStyleColor appStyleColor,
    required AppStyleColor appStyleWhiteColor,
  }) : _appStyleColor = appStyleColor, _appStyleWhiteColor = appStyleWhiteColor;

  static AppStyleTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStyleTheme>() as AppStyleTheme;

  @override
  bool updateShouldNotify(AppStyleTheme oldWidget) =>
      _appStyleColor != oldWidget.appStyleColor ||
      _appStyleWhiteColor != oldWidget.appStyleWhiteColor;

}