import 'package:flutter/material.dart';
import 'package:weather_app/components/weather_detail_tile.dart';
import 'package:weather_app/provider/weather.dart';

class WeatherDetail extends StatelessWidget {

  final WeatherModel weatherModel;

  WeatherDetail(this.weatherModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: <Widget>[
          WeatherDetailTile('Feels Like','${weatherModel.temp.toStringAsFixed(2)} C', Colors.blue),
          WeatherDetailTile('Visibility', weatherModel.visibility, Colors.grey),
          WeatherDetailTile('Pressure',weatherModel.pressure, Colors.grey),
          WeatherDetailTile('Humidity',weatherModel.humidity, Colors.grey),
          WeatherDetailTile('Min Temp','${weatherModel.getMinTemp.toStringAsFixed(2)} C', Colors.blue),
          WeatherDetailTile('Max Temp','${weatherModel.getMaxTemp.toStringAsFixed(2)} C', Colors.blue),
        ],
      ),
    );
  }
}
