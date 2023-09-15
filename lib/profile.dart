import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}



class _profileState extends State<profile> {
  String name='';
  String location='';
  String email='';
  String dob='';
  String noofdays='';
  String images='';
  Map profileData={};
  bool load =true;
  apiCall(){
    print("hhello");
    http.get(Uri.parse("https://randomuser.me/api/")).then((res) {
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      profileData = json.decode(res.body);

      if (res.statusCode == 200) {
        setState(() {
          load=false;
        });

        name = "Name:${profileData["results"][0]["name"]["title"]}${profileData["results"][0]["name"]["first"]}${profileData["results"][0]["name"]["last"]}\n";
        location = "No:${profileData["results"][0]["location"]["street"]["number"]},${profileData["results"][0]["location"]["street"]["name"]}\nCity:${profileData["results"][0]["location"]["city"]}\n"
            "State:${profileData["results"][0]["location"]["state"]}\nCountry:${profileData["results"][0]["location"]["country"]}\nPostcode:${profileData["results"][0]["location"]["postcode"]}";
        email ="Email:${profileData["results"][0]["email"]}";
        images ="${profileData["results"][0]["picture"]["large"]}";
        String formattedDate = DateFormat.yMMMEd().format(DateTime.parse(profileData["results"][0]["registered"]["date"].toString()));
        noofdays ="Number of days passed since registered:$formattedDate";
        String formatDate_dob = DateFormat.yMMMEd().format(DateTime.parse(profileData["results"][0]["dob"]["date"].toString()));
        dob ="DOB:$formatDate_dob";
        images = profileData["results"][0]["picture"]["large"];
      }else{
        load = false;
      }
    });
  }
  void initState() {
    super.initState();
apiCall() ;
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(   appBar: AppBar(
  title: Text("Profile"),
),
  body:  Center(
    child:!load? ListView(shrinkWrap: true,

        children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(name,
            style: TextStyle(
                fontSize: 16)),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(location,
            style: TextStyle(
                fontSize: 16)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(email,
            style: TextStyle(
                fontSize: 16)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(dob,
            style: TextStyle(
                fontSize: 16)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(noofdays,
            style: TextStyle(
                fontSize: 16)),
      ),
      Image.network(images.toString()),
    Container(
      child: ElevatedButton(
        onPressed: ()  {
          setState(() {
            apiCall();
          });
        },
        child: Text("Refresh"),
      ),
    )


        ]):Center(child: CircularProgressIndicator(),),
  )

);
  }
}