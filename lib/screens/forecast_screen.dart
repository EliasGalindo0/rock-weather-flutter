import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'dart:convert';

class ForecastScreen extends StatefulWidget {
  final String city;

  ForecastScreen({required this.city});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? forecastData;

  @override
  void initState() {
    super.initState();
    _loadForecastData();
    _fetchForecast();
  }

  _loadForecastData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('${widget.city}_weather_forecast');
    if (data != null) {
      setState(() {
        forecastData = Map<String, dynamic>.from(json.decode(data));
      });
    }
  }

  _saveForecastData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('${widget.city}_weather_forecast', json.encode(data));
  }

  _fetchForecast() async {
    try {
      final data = await apiService.fetchWeatherForecast(widget.city);
      setState(() {
        forecastData = data;
      });
      _saveForecastData(data);
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5-day Forecast for ${widget.city}'),
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
            child: forecastData != null
                ? SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('Date',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Temp (°C)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Condition',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Icon',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: _buildForecastRows(),
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildForecastRows() {
    List<DataRow> rows = [];
    List forecasts = forecastData!['list'];

    for (var i = 0; i < forecasts.length; i += 8) {
      final item = forecasts[i];
      final dateTime = item['dt_txt'];
      final temp = item['main']['temp'];
      final condition = item['weather'][0]['description'];
      final icon = item['weather'][0]['icon'];

      rows.add(
        DataRow(cells: [
          DataCell(Text(
            dateTime,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            temp.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            condition,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataCell(
              Image.network('http://openweathermap.org/img/wn/$icon@2x.png')),
        ]),
      );
    }

    return rows;
  }
}
