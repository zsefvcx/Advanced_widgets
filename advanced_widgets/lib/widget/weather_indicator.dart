import 'dart:math';

import 'package:advanced_widgets/core/cloud.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Offset> cloud = myCloud;
  Offset position = const Offset(0, 0);
  Offset prevPosition = const Offset(0, 0);

  bool enablePaint = false;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MouseRegion(
            onHover: (event) {
              position = event.localPosition;
              print(position);
              // if (enablePaint && (abs(prevPosition.dx-position.dx)>1 || abs(prevPosition.dy-position.dy)>1)){
              //   cloud.add(position);
              //   print(cloud);
              //   setState(() {
              //   });
              //   prevPosition = position;
              // }
            },
            child: GestureDetector(
              onTap: () {
                // cloud.add(position);
                // //print(cloud);
                // setState(() {
                // });
              },
              onLongPress: () {
                // cloud.clear();
                // //print(cloud);
                // setState(() {
                // });
              },
              onSecondaryTap: () => enablePaint = !enablePaint,
              child: SizedBox(
                width: 300,
                height: 400,
                child: CustomPaint(
                  painter: CustomWeatherIndicator(pressure: widget._pressure, cloud: cloud),
                  willChange: true,
                ),
              ),
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('${widget._pressure} ${cloud.length}'),
          //     TextButton(onPressed: () async {
          //       cloud.clear();
          //       print(cloud);
          //       setState(() {
          //       });
          //     }, child: const Text('X')),
          //     TextButton(onPressed: () async {
          //       final SharedPreferences prefs = await SharedPreferences.getInstance();
          //       await prefs.setString('action', cloud.toString());
          //     }, child: const Text('Сохранить')),
          //   ],
          // ),
        ],
      ),
    );
  }
}

double abs(double d) => d<0?-d:d;

class CustomWeatherIndicator extends CustomPainter{
  final double _opacity;
  final List<Offset> _cloud;

  int get cloudLength => _cloud.length;

  double get pressure => _opacity;

  CustomWeatherIndicator({
    required double pressure,
    required List<Offset> cloud,
  }) : _opacity = pressure, _cloud = cloud;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.deepOrange.withOpacity(_opacity>0.7?0:(-(10/7)*_opacity+1))
        ..strokeWidth = 5
        ..style = PaintingStyle.fill;
    var path = Path()
        ..addOval(Rect.fromCircle(center: const Offset(150,200), radius: 100))
        ..close();
    canvas.drawPath(path, paint);
    var paint2 = Paint()
      ..color = Colors.black12.withOpacity(_opacity<0.3?0:((10/7)*_opacity-(3/7)))
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    var path2 = Path()
      ..addPolygon(_cloud, false)
      ..close();
    canvas.drawPath(path2, paint2);
    var paint3 = Paint()
      ..color = Colors.blue.withOpacity(_opacity<0.7?0:((10/3)*_opacity-7/3))
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    var path3 = Path()
      ..moveTo(95, 319)
      ..lineTo(80, 350)
      ..lineTo(82, 352)
      ..lineTo(98, 315)
      ..moveTo(95+50, 319)
      ..lineTo(80+50, 350)
      ..lineTo(82+50, 352)
      ..lineTo(98+50, 315)
      ..moveTo(95+100, 319)
      ..lineTo(80+100, 350)
      ..lineTo(82+100, 352)
      ..lineTo(98+100, 315)

      ..close();
    canvas.drawPath(path3, paint3);





    //print('repaint with $_cloud');
  }


  @override
  bool shouldRepaint(CustomWeatherIndicator oldDelegate) =>
      _opacity != oldDelegate.pressure ||
  _cloud.length != oldDelegate.cloudLength;
}