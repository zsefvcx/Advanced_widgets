import 'package:flutter/material.dart';

class WeatherIndicator extends StatelessWidget {
  const WeatherIndicator({
    super.key,
    required this.pressure,
  });

  final double pressure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 5, color: Colors.black),
      ),
      width: 50,
      height: 50,
      child: Center(child: Text('$pressure')),
    );
  }
}