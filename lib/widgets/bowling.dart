// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class bowling extends StatefulWidget {
  const bowling({Key? key}) : super(key: key);

  @override
  State<bowling> createState() => _bowlingState();
}

class _bowlingState extends State<bowling> {
  final opposition = ['Sri Lanka', 'Australia', 'Bangladesh', 'New Zealand'];
  final venues = ['Eden park', 'Newlands'];
  var performance=false;

  String? oppositionValue;
  String? venueValue;

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 15),
        ),
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            SizedBox(
              height: 10,
            ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: " name",
                  labelText: "Enter the players name",),
              ),
            ),


            SizedBox(
              height: 10,
            ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.only(left: 50.0, right: 150.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45)),
                child: DropdownButton<String>(
                  value: oppositionValue,
                  hint: Text("Enter Opposition",),
                  // style: TextStyle(color: Colors.black),
                  items: opposition.map(buildMenuItem).toList(),
                  onChanged: (value) =>
                      setState(() => this.oppositionValue = value),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.only(left: 50.0, right: 183.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45)),
                child: DropdownButton<String>(
                  value: venueValue,
                  hint: Text("Enter Venue",),
                  // style: TextStyle(color: Colors.black),
                  items: venues.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.venueValue = value),
                ),
              ),
            ),


            SizedBox(
              height: 10,
            ),


            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text('Predict',),
                onPressed: () {
                  setState(() {
                    performance =true;
                  });
                },
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: EdgeInsets.only(left: 80.0, right: 110.0),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  // border: Border.all(
                  //     color: Colors.white, // Set border color
                  //     width: 2.0),   // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                  // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                ),

                child: Visibility(
                  visible: performance,
                  child: Text(
                    'Performance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      height: 1,
                    ),

                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
