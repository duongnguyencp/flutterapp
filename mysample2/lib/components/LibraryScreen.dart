import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {

    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      setState(() {
        if(x > 0){
          direction = "back";
        }else if(x < 0){
          direction = "forward";
        }else if(y > 0){
          direction = "left";
        }else if(y < 0){
          direction = "right";
        }
      });


    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope Sensor in Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Column(
              children:[
                Text(direction, style: TextStyle(fontSize: 30),)
              ]
          )
      ),

    );
  }
}