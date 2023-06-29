import 'package:advanced_widgets/core/cloud.dart';
import 'package:advanced_widgets/widget/theme_inherited.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Использовать CustomPaint

class WeatherIndicator extends StatefulWidget {
  const WeatherIndicator({
    super.key,
    required double pressure,
    required AppStyleColor appStyleColor,
  }) : _pressure = pressure, _appStyleColor = appStyleColor;

  final AppStyleColor _appStyleColor;
  final double _pressure;

  @override
  State<WeatherIndicator> createState() => _WeatherIndicatorState();
}

class _WeatherIndicatorState extends State<WeatherIndicator> {
  List<Offset> cloud = myCloud;
  Offset position = const Offset(0, 0);
  Offset prevPosition = const Offset(0, 0);
  bool   _tabScale = false;
  bool enablePaint = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('build WeatherIndicator');
    return Transform.scale(
      scale: _tabScale?1.0:0.3,
      origin: const Offset(150, -200),
      child: Container(
        decoration: BoxDecoration(
          color: widget._appStyleColor.appBackgroundColor,
          border: Border.all(width: 1, color: widget._appStyleColor.appBarBackgroundColor),
        ),
        width: 300,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              onHover: (event) {
                //position = event.localPosition;
                //print(position);
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
                  _tabScale = !_tabScale;
                  setState(() {
                  });
                },
                onLongPress: () {
                  // cloud.clear();
                  // //print(cloud);
                  // setState(() {
                  // });
                },
                onSecondaryTap: () => enablePaint = !enablePaint,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(300, 300),
                      painter: CustomWeatherIndicator(pressure: widget._pressure, cloud: cloud),
                      //willChange: true,
                    ),
                    if (_tabScale)
                      Text('Облачно,\n12 градусов!',
                      style: TextStyle(color: widget._appStyleColor.textColor),
                      ),
                  ],
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
    const double dy = 50;

    var paint = Paint()
        ..color = Colors.deepOrange.withOpacity(_opacity>0.7?0:(-(10/7)*_opacity+1))
        ..strokeWidth = 5
        ..style = PaintingStyle.fill;
    var path = Path()
        ..addOval(Rect.fromCircle(center: const Offset(150,200-dy), radius: 100))
        ..close();
    canvas.drawPath(path, paint);
    var paint2 = Paint()
      ..color = Colors.grey.withOpacity(_opacity<0.3?0:((10/7)*_opacity-(3/7)))
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    final List<Offset> cloud = [];
    for (var element in _cloud) {
      cloud.add(Offset(element.dx, element.dy-dy));
    }

    var path2 = Path()
      ..addPolygon(cloud, false)
      ..close();
    canvas.drawPath(path2, paint2);
    var paint3 = Paint()
      ..color = Colors.blue.withOpacity(_opacity<0.7?0:((10/3)*_opacity-7/3))
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    var path3 = Path()
      ..moveTo(95, 319-dy)
      ..lineTo(80, 350-dy)
      ..lineTo(82, 352-dy)
      ..lineTo(98, 315-dy)
      ..moveTo(95+50, 319-dy)
      ..lineTo(80+50, 350-dy)
      ..lineTo(82+50, 352-dy)
      ..lineTo(98+50, 315-dy)
      ..moveTo(95+100, 319-dy)
      ..lineTo(80+100, 350-dy)
      ..lineTo(82+100, 352-dy)
      ..lineTo(98+100, 315-dy)

      ..close();
    canvas.drawPath(path3, paint3);





    //print('repaint with $_cloud');
  }


  @override
  bool shouldRepaint(CustomWeatherIndicator oldDelegate) =>
      _opacity != oldDelegate.pressure ||
  _cloud.length != oldDelegate.cloudLength;
}