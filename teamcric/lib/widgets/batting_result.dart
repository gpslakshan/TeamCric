// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/player.dart';

class BattingResult extends StatefulWidget {
  String teamName;
  String oppName;
  String venueName;

  BattingResult(this.teamName, this.oppName, this.venueName);

  @override
  State<BattingResult> createState() => _BattingResultState();
}

class _BattingResultState extends State<BattingResult> {
  // var output = "";
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TeamCric'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                widget.teamName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Batting Performance Prediction Results',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<List<Player>>(
                stream: readPlayers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].teamName == widget.teamName &&
                          snapshot.data![i].role != 'BOWL') {
                        players.add(snapshot.data![i]);
                      }
                    }
                    print(players);
                    print(players.length);
                    return FutureBuilder(
                      future: getPerformance(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading.."),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    players[index].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            players[index].imageUrl),
                                      ),
                                    ),
                                    height: 100,
                                    width: 50,
                                  ),
                                  subtitle: Text(
                                    players[index].role,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Text(
                                    snapshot.data[index],
                                    style: TextStyle(
                                      color: snapshot.data[index] == 'Low'
                                          ? Colors.red
                                          : Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              primary: false,
                              shrinkWrap: true,
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> predictPerformance(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/predict");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        print(result["Prediction"]);
        return result["Prediction"];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  int? getOppId(String opponentName) {
    final teams = {
      'West Indies': 8,
      'New Zealand': 4,
      'Pakistan': 5,
      'Australia': 0,
      'England': 2,
      'Sri Lanka': 7,
      'Bangladesh': 1,
      'South Africa': 6,
      'India': 3
    };
    return teams[opponentName];
  }

  int? getVenueId(String venueName) {
    final venues = {
      "Bay Oval, Mount Maunganui": 2,
      "Westpac Trust Stadium": 51,
      "Eden Park": 13,
      "Bay Oval": 1,
      "Sydney Cricket Ground": 42,
      "Bellerive Oval": 3,
      "Melbourne Cricket Ground": 26,
      "Westpac Stadium": 50,
      "Shere Bangla National Stadium": 38,
      "Wanderers Stadium": 47,
      "Sylhet Stadium": 43,
      "Seddon Park": 36,
      "SuperSport Park": 41,
      "Newlands": 31,
      "R Premadasa Stadium": 34,
      "National Stadium (Karachi)": 30,
      "Edgabston": 14,
      "Old Trafford": 32,
      "Sophia Gardens": 39,
      "Warner Park": 49,
      "Central Broward Regional Park": 7,
      "Sheikh Zayed Stadium": 37,
      "Dubai International Cricket Stadium": 11,
      "Eden Gardens": 12,
      "Ekana International Cricket Stadium": 15,
      "Metricon Stadium": 27,
      "Brisbane Cricket Ground": 5,
      "Dr YS Rajasekhara Reddy Cricket Stadium": 10,
      "M Chinnaswamy Stadium": 22,
      "Daren Sammy National Cricket Stadium": 9,
      "Pallekele International Cricket Stadium": 33,
      "Gaddafi Stadium": 16,
      "Arun Jaitley Stadium": 0,
      "Manuka Oval": 24,
      "Saxton Oval": 35,
      "Greenfield International Stadium": 17,
      "Wankhede Stadium": 48,
      "Holkar Cricket Stadium": 20,
      "Maharashtra Cricket Association Stadium": 23,
      "Buffalo Park": 6,
      "Kingsmead": 21,
      "St George's Park": 40,
      "The Rose Bowl": 44,
      "Boland Park": 4,
      "McLean Park": 25,
      "Hagley Oval": 18,
      "University Oval": 46,
      "Coolidge Cricket Ground": 8,
      "Narendra Modi Stadium": 28,
      "National Cricket Stadium (Grenada)": 29,
      "Trent Bridge": 45,
      "Headingley": 19
    };
    return venues[venueName];
  }

  Future<List<String>> getPerformance() async {
    List<String> performances = [];
    for (int i = 0; i < players.length; i++) {
      var body = [
        {
          'player_id': int.parse(players[i].battingId),
          'opp_id': getOppId(widget.oppName),
          'venue_id': getVenueId(widget.venueName)
        }
      ];
      print(body);
      var resp = await predictPerformance(body);
      performances.add(resp.toString());
    }
    print(performances);
    return performances;
  }
}

Stream<List<Player>> readPlayers() => FirebaseFirestore.instance
    .collection('players')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());
