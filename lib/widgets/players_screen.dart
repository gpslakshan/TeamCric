// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PlayersPage extends StatefulWidget {
  final String teamName;
  const PlayersPage(this.teamName);

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TeamCric',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(child: Text('Players page')),
    );
  }
}
