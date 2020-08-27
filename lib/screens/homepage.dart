import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/place_detail.dart';
import 'package:weather_app/components/search_box.dart';
import 'package:weather_app/components/sun_details_tile.dart';
import 'package:weather_app/components/weather_detail.dart';
import 'package:weather_app/components/weather_type.dart';
import 'package:weather_app/provider/weather.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  var _init = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(!_init){
      Provider.of<Weather>(context, listen: false).getData();
      _init = true;
    }


  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final weatherData = Provider.of<Weather>(context).weatherModel;
    if(weatherData ==null){
      _init = false;
    }
    var image;



    final topContainerSize = height * 0.315;
    final bottomContainerSize = height * 0.65;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: topContainerSize,
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    children: <Widget>[
                      SearchBox(topContainerSize * 0.20),
                      SizedBox(
                        height: 20,
                      ),
                      weatherData!=null
                      ? WeatherType(weatherData)
                      : Center(),
                    ],
                  ),
                ),
                weatherData!=null ? Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: bottomContainerSize * 0.10),
                      child: Column(
                        children: <Widget>[
                          PlaceDetail(weatherData),
                          SizedBox(
                            height: 30,
                          ),
                          WeatherDetail(weatherData),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Sunrise and Sunset:',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SunDetailsTile('assets/images/sunrise.jpg',weatherData.sunrise),
                                    SunDetailsTile('assets/images/sunset.jpg',weatherData.sunset),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ) : Center(child: CircularProgressIndicator(),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
