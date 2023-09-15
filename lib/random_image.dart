import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class random_image extends StatefulWidget {
  @override
  _random_imageState createState() => _random_imageState();
}



class _random_imageState extends State<random_image> {
  String imageList="";
  bool load = true;
  apiCall(){
    http.get(Uri.parse("https://dog.ceo/api/breeds/image/random")).then((res) {
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      Map getURL = json.decode(res.body);
      if (res.statusCode == 200) {
        setState(() {
          load=false;
        });
        imageList =Uri.parse(getURL["message"]).toString();
        print("Response imageList: ${imageList}");
      }else{
        setState(() {
          load=false;
        });
      }
    });
  }
  var button;

  void initState() {
    super.initState();
    print("helllo");
    apiCall();
    button =Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        onPressed: ()  {
          setState(() {
            apiCall();
          });
        },
        child: Text("Refresh"),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Random Images"),
        ),
        body: !load? ListView(
          children: [
            button,
            GridView.builder(
                shrinkWrap:true,
                itemCount: 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2, ),
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                        children:[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(imageList.toString(),
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.17,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ]
                    ),
                  );
                }),
            button
          ],
        ):Center(child: CircularProgressIndicator())
    );
  }

}