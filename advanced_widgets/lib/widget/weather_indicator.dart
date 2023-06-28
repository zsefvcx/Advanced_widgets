import 'dart:math';

import 'package:flutter/material.dart';

//Использовать CustomPaint

class WeatherIndicator extends StatefulWidget {
  const WeatherIndicator({
    super.key,
    required double pressure,
  }) : _pressure = pressure;

  final double _pressure;

  @override
  State<WeatherIndicator> createState() => _WeatherIndicatorState();
}

class _WeatherIndicatorState extends State<WeatherIndicator> {
  List<Offset> cloud = [];
  Offset position = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    debugPrint('build WeatherIndicator');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 5, color: Colors.black),
      ),
      width: 300,
      height: 450,
      child: Center(child: Column(
        children: [
          MouseRegion(
            onHover: (event) => position = event.localPosition,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  cloud.add(position);
                  print(cloud);
                });
              },
              onLongPress: () {
                setState(() {
                  cloud.clear();
                  print(cloud);
                });
              },
              child: SizedBox(
                width: 300,
                height: 400,
                child: CustomPaint(
                  painter: CustomWeatherIndicator(pressure: widget._pressure, cloud: cloud),
                ),
              ),
            ),
          ),
          Text('${widget._pressure}'),
        ],
      )),
    );
  }
}

class CustomWeatherIndicator extends CustomPainter{
  final double _pressure;
  final List<Offset> _cloud;

  int get cloudLength => _cloud.length;

  double get pressure => _pressure;

  CustomWeatherIndicator({
    required double pressure,
    required List<Offset> cloud,
  }) : _pressure = pressure, _cloud = cloud;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.deepOrange
        ..strokeWidth = 5
        ..style = PaintingStyle.fill;
    var path = Path()
        ..addOval(Rect.fromCircle(center: const Offset(150,200), radius: 100))
        ..close();
    canvas.drawPath(path, paint);
    var paint2 = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    var path2 = Path()
      ..addPolygon(_cloud, false)
      ..close();


    canvas.drawPath(path2, paint2);
    print('repaint with $_cloud');
  }


  @override
  bool shouldRepaint(CustomWeatherIndicator oldDelegate) =>
      _pressure != oldDelegate.pressure ||
  _cloud.length != oldDelegate.cloudLength;
}