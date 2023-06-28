import 'package:flutter/material.dart';

import 'my_home_page.dart';
import 'widget/theme_inherited.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppStyleTheme(
      appStyleColor: AppStyleColor(
        appBackgroundColor: Colors.black,
        appBarBackgroundColor: Colors.orange,
        appBarTextColor: Colors.indigo,
        textColor: Colors.deepOrangeAccent,
        buttonBackgroundColor: Colors.orangeAccent,
        buttonIconColor: Colors.indigo,
      ),
      appStyleWhiteColor: AppStyleColor(
        appBackgroundColor: Colors.white,
        appBarBackgroundColor: Colors.blueAccent,
        appBarTextColor: Colors.white,
        textColor: Colors.deepOrangeAccent,
        buttonBackgroundColor: Colors.blue,
        buttonIconColor: Colors.white,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
