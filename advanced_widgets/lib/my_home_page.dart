
import 'package:flutter/material.dart';

import 'widget/theme_inherited.dart';
import 'widget/weather_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool _invertColor = false;

  double _pressure = 0;

  @override
  Widget build(BuildContext context) {
    final appStyleColor = _invertColor?AppStyleTheme.of(context).appStyleWhiteColor:AppStyleTheme.of(context).appStyleColor;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                WeatherIndicator(pressure: _pressure),
                Column(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          Icon(Icons.sunny, color: appStyleColor.textColor),
                          Text(
                            '   Weather:',
                            style: TextStyle(color: appStyleColor.textColor),
                          ),
                        ],
                      ),
                      Slider(
                        value: _pressure,
                        label: '$_pressure',
                        divisions: 50,
                        min: 0,
                        max: 1,
                        activeColor: appStyleColor.textColor,
                        inactiveColor: appStyleColor.buttonBackgroundColor,
                        onChanged: (v) => setState(() {
                          _pressure = ((v*100).round()/100);
                        })
                      ),
                    ]),
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
            tooltip: 'BW Colors',
            backgroundColor: appStyleColor.buttonBackgroundColor,
            child: Icon(Icons.invert_colors,
              size: 40,
              color: appStyleColor.buttonIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
