import 'package:flutter/material.dart';
import 'screens/concerts_screen.dart';
import 'screens/current_weather_screen.dart';
import 'screens/forecast_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Rock\'n\'Roll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConcertsScreen(),
      routes: {
        '/current_weather': (context) => CurrentWeatherScreen(
            city: ModalRoute.of(context)!.settings.arguments as String),
        '/forecast': (context) => ForecastScreen(
            city: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
