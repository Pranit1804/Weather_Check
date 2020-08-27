import 'package:flutter/material.dart';
import 'package:weather_app/provider/weather.dart';

class WeatherType extends StatelessWidget {

  final WeatherModel weatherModel;

  const WeatherType(this.weatherModel);

  @override
  Widget build(BuildContext context) {


    return Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child:weatherModel!= null ?  Image.asset(
                weatherModel.image,
                fit: BoxFit.cover,
                height: 80,
                width: 90,
              ) : Center(child: CircularProgressIndicator(),),
            ),
            SizedBox(width: 40,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: '${weatherModel!=null ?weatherModel.getTemp.toStringAsFixed(0) : 'NA'} C\n',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,)
                    ),
                    TextSpan(
                        text: weatherModel.weatherType,
                        style: TextStyle(fontSize: 22,)
                    )
                  ]
              ),
            )
          ],
        ),
    );
  }
}
