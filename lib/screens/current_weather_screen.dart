import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'forecast_screen.dart';
import 'dart:convert';

class CurrentWeatherScreen extends StatefulWidget {
  final String city;

  CurrentWeatherScreen({required this.city});

  @override
  _CurrentWeatherScreenState createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
    _fetchWeather();
  }

  _loadWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('${widget.city}_current_weather');
    if (data != null) {
      setState(() {
        weatherData = Map<String, dynamic>.from(json.decode(data));
      });
    }
  }

  _saveWeatherData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('${widget.city}_current_weather', json.encode(data));
  }

  _fetchWeather() async {
    try {
      final data = await apiService.fetchCurrentWeather(widget.city);
      setState(() {
        weatherData = data;
      });
      _saveWeatherData(data);
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Weather in ${widget.city}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/IM.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                weatherData != null
                    ? Column(
                        children: [
                          Text(
                            'Temperature: ${weatherData!['main']['temp']} °C',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Condition: ${weatherData!['weather'][0]['description']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.network(
                            'http://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
                          ),
                        ],
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForecastScreen(city: widget.city),
                      ),
                    );
                  },
                  child: Text('See 5-day Forecast'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
