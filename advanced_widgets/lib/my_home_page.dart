
import 'package:flutter/material.dart';

import 'widget/theme_inherited.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool _invertColor = false;


  @override
  Widget build(BuildContext context) {
    final appStyleColor = _invertColor?AppStyleTheme.of(context).appStyleInvertColor:AppStyleTheme.of(context).appStyleColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appStyleColor.appBarBackgroundColor,
        title: Text(widget.title,
        style: TextStyle(color: appStyleColor.appBarTextColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: appStyleColor.appBackgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(color: appStyleColor.textColor),
                ),
                Text(
                  '$_counter',
                  style: TextStyle(color: appStyleColor.textColor),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: ()=> setState(() {
              _counter++;
            }),
            tooltip: 'Increment',
            backgroundColor: appStyleColor.buttonBackgroundColor,
            child: Icon(Icons.add,
              color: appStyleColor.buttonIconColor,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: ()=> setState(() {
              _invertColor = !_invertColor;
            }),
            tooltip: 'Invert Colors',
            backgroundColor: appStyleColor.buttonBackgroundColor,
            child: Icon(Icons.invert_colors,
              color: appStyleColor.buttonIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
