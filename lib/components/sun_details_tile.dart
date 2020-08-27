import 'package:flutter/material.dart';

class SunDetailsTile extends StatelessWidget {

  final time,  image;

  const SunDetailsTile(this.image, this.time);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(),
        child: Column(
          children: <Widget>[
            Image.asset(image, height: 80, width: 100,),
            Text(
              time,
              style: TextStyle(
                  inherit: true,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
