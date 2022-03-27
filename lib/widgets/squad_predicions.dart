// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:teamcric/widgets/result.dart';

class Playing11PredictionScreen extends StatefulWidget {
  const Playing11PredictionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Playing11PredictionScreen> createState() =>
      _Playing11PredictionScreenState();
}

class _Playing11PredictionScreenState extends State<Playing11PredictionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? valueTeam;
  String? valueOpponent;
  String? valueVenue;
  final teams = [
    'West Indies',
    'New Zealand',
    'Pakistan',
    'Australia',
    'England',
    'Sri Lanka',
    'Bangladesh',
    'South Africa',
    'India',
  ];

  final venues = [
    "Bay Oval, Mount Maunganui",
    "Westpac Trust Stadium",
    "Eden Park",
    "Bay Oval",
    "Sydney Cricket Ground",
    "Bellerive Oval",
    "Melbourne Cricket Ground",
    'Westpac Stadium',
    'Shere Bangla National Stadium',
    'Wanderers Stadium'	,
    'Sylhet Stadium'	,
    'Seddon Park'	,
    'SuperSport Park'	,
    'Newlands'	,
    'R Premadasa Stadium',
    'National Stadium (Karachi)'	,
    'Edgbaston'	,
    'Old Trafford',
    'Sophia Gardens',
    'Warner Park',
    'Central Broward Regional Park',
    'Sheikh Zayed Stadium'	,
    'Dubai International Cricket Stadium',
    'Eden Gardens'	,
    'Ekana International Cricket Stadium'	,
    'Metricon Stadium'	,
    'Brisbane Cricket Ground',
    'Dr YS Rajasekhara Reddy Cricket Stadium'	,
    'M Chinnaswamy Stadium'	,
    'Daren Sammy National Cricket Stadium',
    'Pallekele International Cricket Stadium',
    'Gaddafi Stadium'	,
    'Arun Jaitley Stadium'	,
    'Manuka Oval'	,
    'Saxton Oval',
    'Greenfield International Stadium'	,
    'Wankhede Stadium'	,
    'Holkar Cricket Stadium',
    'Maharashtra Cricket Association Stadium'	,
    'Buffalo Park'	,
    'Kingsmead'	,
    'St Georges Park',
    'The Rose Bowl'	,
    'Boland Park',
    'McLean Park',
    'Hagley Oval',
    'University Oval'	,
    'Coolidge Cricket Ground',
    'Narendra Modi Stadium'	,
    'National Cricket Stadium (Grenada)',
    'Trent Bridge'	,
    'Headingley'

  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.white38,
                tabs: [
                  Tab(text: 'Batting'),
                  Tab(text: 'Bowling'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Team Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //Batting Tab
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Team'),
                            value: valueTeam,
                            isExpanded: true,
                            items: teams.map(buildTeamMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueTeam = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Opponent Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Opponent'),
                            value: valueOpponent,
                            isExpanded: true,
                            items: teams.map(buildTeamMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueOpponent = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ground Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Venue'),
                            value: valueVenue,
                            isExpanded: true,
                            items: venues.map(buildVenueMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueVenue = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Result(
                                    valueTeam!, valueOpponent!, valueVenue!),
                              ),
                            );
                          },
                          child: Text('Predict'),
                        ),
                      )
                    ],
                  ),

                  //Bowling Tab
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Team Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Team'),
                            value: valueTeam,
                            isExpanded: true,
                            items: teams.map(buildTeamMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueTeam = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Opponent Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Opponent'),
                            value: valueOpponent,
                            isExpanded: true,
                            items: teams.map(buildTeamMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueOpponent = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ground Name',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Select Venue'),
                            value: valueVenue,
                            isExpanded: true,
                            items: venues.map(buildVenueMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valueVenue = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Result(
                                    valueTeam!, valueOpponent!, valueVenue!),
                              ),
                            );
                          },
                          child: Text('Predict'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildTeamMenuItem(String item) => DropdownMenuItem(
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        value: item,
      );

  DropdownMenuItem<String> buildVenueMenuItem(String item) => DropdownMenuItem(
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        value: item,
      );
}
