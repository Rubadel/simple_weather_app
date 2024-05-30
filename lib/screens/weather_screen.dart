import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:simple_weather_app/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _WeatherService = WeatherService("46e990836c148d103e7f02eaba02570a");
  Weather? _Weather;

  Color? _bkgColor;

  _fetchWeather() async {
    double lat = await _WeatherService.getCurentLat();
    double lon = await _WeatherService.getCurentLon();
    try {
      final weather = await _WeatherService.getWeather(lat, lon);
      setState(() {
        _Weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

//for animation
  String getWeatherAnimation(String? mainWeather) {
    if (mainWeather == null) return 'assets/sun.json';

    switch (mainWeather.toLowerCase()) {
      case 'clouds':
         _bkgColor = Colors.grey;
        return 'assets/cloud.json';
      case 'dust':
        _bkgColor = Colors.brown[500];
        return 'assets/dust.json';
      case 'clear':
        _bkgColor = Colors.yellow[500];
        return 'assets/sun.json';
      default:
        _bkgColor = Colors.black87;
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bkgColor,
      appBar: AppBar( backgroundColor: Colors.grey[200],
          title: Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(' Weather App '),Icon(Icons.sunny)],
      )),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_Weather?.cityName ?? "Loading..", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 23),),
              SizedBox(height: 10,),
              Text('${_Weather?.temp.round()} °C', style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),),
              Lottie.asset(getWeatherAnimation(_Weather?.mainWeather)),
              Text(_Weather!.mainWeather, style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
