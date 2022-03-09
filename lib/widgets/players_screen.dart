// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamcric/models/player.dart';

class PlayersPage extends StatefulWidget {
  final String teamName;
  final String teamImageUrl;
  const PlayersPage(this.teamName, this.teamImageUrl);

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.teal,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            actions: [
              Icon(Icons.settings),
              SizedBox(
                width: 20,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.teamImageUrl,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                widget.teamName,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          buildPlayers(),
        ],
      ),
    );
  }

  Stream<List<Player>> readPlayers() => FirebaseFirestore.instance
      .collection('players')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());

  Widget buildPlayers() => SliverToBoxAdapter(
        child: StreamBuilder<List<Player>>(
          stream: readPlayers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Player> players = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].teamName == widget.teamName) {
                  players.add(snapshot.data![i]);
                }
              }
              return Container(
                height: 2000,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(players[index].imageUrl),
                              ),
                            ),
                            height: 100,
                            width: 50,
                          ),
                          title: Text(
                            players[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            players[index].role,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: players.length,
                    primary: false,
                    shrinkWrap: true,
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
