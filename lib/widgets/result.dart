// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/player.dart';

class Result extends StatefulWidget {
  String teamName;
  String oppName;
  String venueName;

  Result(this.teamName, this.oppName, this.venueName);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<List<Player>>(
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
                              title: Text(players[index].name),
                              leading: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(players[index].imageUrl),
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
                              trailing: Text(snapshot.data[index]),
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

  int getOppId(String value) {
    final teams = [
      'West Indies',
      'New Zealand',
      'Pakistan',
      'Australia',
      'England',
      'Sri Lanka',
      'Bangladesh',
      'South Africa',
      'India'
    ];
    var index = teams.indexOf(value);

    List<int> oppIds = [8, 4, 5, 0, 2, 7, 1, 6, 3];
    final oppId = oppIds[index];
    return oppId;
  }

  getVenueId(String venueName) {
    final venueList = [
      "Bay Oval, Mount Maunganui",
      "Westpac Trust Stadium",
      "Eden Park",
      "Bay Oval",
      "Sydney Cricket Ground",
      "Bellerive Oval",
      "Melbourne Cricket Ground",
    ];
    var index = venueList.indexOf(venueName);
    List<int> venueIds = [2, 51, 13, 1, 42, 3, 26];
    final venueId = venueIds[index];
    return venueId;
  }

  Future<List<String>> getPerformance() async {
    // var body = [
    //   {
    //     'player_id': int.parse(player.battingId),
    //     'opp_id': getOppId(widget.oppName),
    //     'venue_id': getVenueId(widget.venueName)
    //   }
    // ];
    // print(body);
    // setState(() {
    //   output = resp!.toString();
    // });

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
