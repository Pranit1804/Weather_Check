import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherModel {
  final temp;
  final pressure;
  final minTemp;
  final maxTemp;
  final humidity;
  final feelsLike;
  final visibility;
  final sunset;
  final sunrise;
  final country;
  final city;
  final weatherType;
  final long;
  final lat;
  final image;

  WeatherModel(
    this.temp,
    this.pressure,
    this.minTemp,
    this.maxTemp,
    this.humidity,
    this.feelsLike,
    this.visibility,
    this.sunrise,
    this.sunset,
    this.country,
    this.city,
    this.weatherType,
    this.long,
    this.lat,
    this.image,
  );

  double get getMaxTemp => maxTemp - 272.5;

  double get getMinTemp => minTemp - 272.5;

  double get getTemp => temp - 272.5;

  double get getfeelsLike => feelsLike - 272.5;
}

class Weather with ChangeNotifier {
  final API_KEY = "ebbc723b08bef91adb170b9018b49029";
  Map weatherData;

  WeatherModel _weatherModel;

  WeatherModel get weatherModel {
    return _weatherModel;
  }

  Future getData({String cityName = ""}) async {
    if (cityName.isEmpty) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
      final startUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$API_KEY";
      http.Response response = await http.get(startUrl);
      print('Response: ${response.body}');
      weatherData = json.decode(response.body);
      final weatherType = weatherData["weather"][0]["main"];
      var image;
      if (weatherType.toString() == 'Haze' ||
          weatherType.toString() == 'Rain' ||
          weatherType.toString() == 'Drizzle') {
        image = 'assets/images/rain.png';
      } else {
        image = 'assets/images/sun.jg';
      }

      _weatherModel = new WeatherModel(
          weatherData["main"]["temp"],
          weatherData["main"]["pressure"],
          weatherData["main"]["temp_min"],
          weatherData["main"]["temp_max"],
          weatherData["main"]["humidity"],
          weatherData["main"]["feels_like"],
          weatherData["visibility"],
          '${getClockInUtcPlus3Hours(weatherData["sys"]['sunrise'] as int)} AM IST',
          '${getClockInUtcPlus3Hours(weatherData["sys"]['sunset'] as int)} PM IST',
          weatherData["sys"]["country"],
          weatherData["name"],
          weatherData["weather"][0]["main"],
          weatherData["coord"]["lon"],
          weatherData["coord"]["lat"],
          image);
    } else {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY";
      print('URL: $url');
      http.Response response = await http.get(url);
      print('Response: ${response.body}');
      weatherData = json.decode(response.body);
      final weatherType = weatherData["weather"][0]["main"];
      var image;

      if (weatherType.toString() == 'Haze' ||
          weatherType.toString() == 'Rain' ||
          weatherType.toString() == 'Drizzle') {
        image = 'assets/images/rain.png';
      } else {
        image = 'assets/images/sun.png';
      }

      _weatherModel = new WeatherModel(
        weatherData["main"]["temp"],
        '${weatherData["main"]["pressure"]}hPa',
        weatherData["main"]["temp_min"],
        weatherData["main"]["temp_max"],
        weatherData["main"]["humidity"],
        weatherData["main"]["feels_like"],
        weatherData["visibility"],
        '${getClockInUtcPlus3Hours(weatherData["sys"]['sunrise'] as int)} AM IST',
        '${getClockInUtcPlus3Hours(weatherData["sys"]['sunset'] as int)} PM IST',
        weatherData["sys"]["country"],
        weatherData["name"],
        weatherData["weather"][0]["main"],
        weatherData["coord"]["lon"],
        weatherData["coord"]["lat"],
        image,
      );
    }
    notifyListeners();
  }
  String getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
        isUtc: true)
        .add(const Duration(hours: 3));
    return '${time.hour}:${time.second}';
  }
}
