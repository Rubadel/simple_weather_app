
import 'dart:convert';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/models/weather_model.dart';

class WeatherService {

// https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key}

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(double lat, double lon) async{
    final response = await http.get(Uri.parse('$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey')); 

    if(response.statusCode == 200 ){
          print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Faild to load weather');
    }
  }

  Future<double> getCurentLat() async {
    //get permission
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
    }

    //get Current  position to get the lat and lon
    Position position = await Geolocator.getCurrentPosition();
    // get the lat and lon
    double lat = position.latitude;


    //convert loaction into list of placemarks objects to get city name
    // get city name
    // String? city = placemarks[0].locality;
    // return city ?? "";

    print('LAATT $lat');
    return lat;
  }

    Future<double> getCurentLon() async {
    //get permission
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
    }

    //get Current  position to get the lat and lon
    Position position = await Geolocator.getCurrentPosition();
    // get the lat and lon
    double lon = position.longitude;


    //convert loaction into list of placemarks objects to get city name
    // get city name
    // String? city = placemarks[0].locality;
    // return city ?? "";

    print('LLOONN $lon');
    return lon;
  }  
}