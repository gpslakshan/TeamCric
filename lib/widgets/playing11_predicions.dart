// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teamcric/widgets/batting.dart';
import 'package:teamcric/widgets/bowling.dart';

class Playing11PredictionScreen extends StatelessWidget {
  const Playing11PredictionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(appBar: AppBar(
      toolbarHeight: 0.0,
      bottom: TabBar(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0),
            insets: EdgeInsets.symmetric(horizontal:16.0)
        ),
        tabs: [
          Tab(text: 'Batting',icon: Icon(Icons.sports_cricket_sharp),),
          Tab(text: 'Bowling',icon: Icon(Icons.sports_cricket_rounded),),
        ],
      ),
    ),
      body: TabBarView(
        children: [
          batting(),
          bowling(),
        ],
      ),
    ),
  );
  }

