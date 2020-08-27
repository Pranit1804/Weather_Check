import 'package:flutter/material.dart';
import 'package:weather_app/provider/weather.dart';
class PlaceDetail extends StatelessWidget {

  final WeatherModel weatherModel;

  const PlaceDetail(this.weatherModel);
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${weatherModel.city}, ${weatherModel.country !=null ? weatherModel.country: ''}', style: TextStyle(fontSize: 25, inherit: true, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.battery_full, color: Colors.black54, size: 18,)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.location_on, color: Colors.deepOrange, size: 18,),
            SizedBox(height: 3,),
            Text('${weatherModel.lat}, ${weatherModel.long}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
