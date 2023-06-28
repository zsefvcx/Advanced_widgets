import 'dart:math';

import 'package:flutter/material.dart';

//Использовать CustomPaint
List<Offset> cloud = [];
Offset position = const Offset(0, 0);

class WeatherIndicator extends StatelessWidget {
  const WeatherIndicator({
    super.key,
    required double pressure,
  }) : _pressure = pressure;

  final double _pressure;

  @override
  Widget build(BuildContext context) {
    cloud.clear();
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
            onHover: (event) => position = event.position,
            child: GestureDetector(
              onTap: () {
                cloud.add(position);
                print(cloud);
              },
              child: SizedBox(
                width: 300,
                height: 400,
                child: CustomPaint(
                  painter: CustomWeatherIndicator(pressure: _pressure),
                ),
              ),
            ),
          ),
          Text('$_pressure'),
        ],
      )),
    );
  }
}

class CustomWeatherIndicator extends CustomPainter{
  final double _pressure;

  double get pressure => _pressure;

  CustomWeatherIndicator({required double pressure}) : _pressure = pressure;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.fill;
    var path = Path()
        ..addOval(Rect.fromCircle(center: const Offset(150,200), radius: 100));
    canvas.drawPath(path, paint);
    var paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    var path2 = Path()
      ..moveTo(50, 200)
      ..addPolygon(cloud,
       true);

    canvas.drawPath(path2, paint2);

    canvas.drawPath(path2, paint2);
    print('repaint with $cloud');
  }


  @override
  bool shouldRepaint(CustomWeatherIndicator oldDelegate) => _pressure != oldDelegate.pressure;
}