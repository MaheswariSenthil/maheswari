import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/profile.dart';
import 'package:testing_app/random_image.dart';

void main() {
  runApp( MyApp());
}



class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter assignment"),
      ),
      body:   Column(
        children: [

          Container(
            child: ElevatedButton(
              onPressed: ()  {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return random_image();
                    }));
              },
              child: Text("Random Images"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: ()  {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (BuildContext context) {
                //       return TrendMeter();
                //     }));
              },
              child: Text("Enable Bluetooth"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: ()  {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return profile();
                    }));
              },
              child: Text("Profile"),
            ),
          ),
        ],
      )
    );
  }
}
