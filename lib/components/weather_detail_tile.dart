import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {

  final temp, title, color;

  const WeatherDetailTile(this.title, this.temp, this.color);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(),
        child: Column(
          children: <Widget>[
            Text(
              '$title \n',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              temp!=null ? temp.toString() : 'NA',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color),
            )
          ],
        ),
      ),
    );
  }
}
