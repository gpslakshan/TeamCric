// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/team.dart';
import 'players_screen.dart';

class TeamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1500,
      padding: EdgeInsets.all(12),
      child: StreamBuilder<List<Team>>(
        stream: readTeams(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final teams = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return buildTeam(team, context);
              },
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

  Stream<List<Team>> readTeams() => FirebaseFirestore.instance
      .collection('teams')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Team.fromJson(doc.data())).toList());

  Widget buildTeam(Team team, BuildContext context) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlayersPage(team.name)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(team.imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.58), BlendMode.darken),
            ),
          ),
          child: Center(
            child: Text(
              team.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}
