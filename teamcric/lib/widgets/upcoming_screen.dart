import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _Data = [
  {
    "albumId": 1,
    "id": 1,
    "title": "Indian Premier League 2022",
    "teams": 'Chennai Super Kings vs Kolkata Knight Riders',
    "date": "SAT, MAR 26 2022",
    "group": "Wankhede Stadium, Mumbai",
  },
  {
    "albumId": 1,
    "id": 2,
    "title": "Indian Premier League 2022",
    "teams": 'Delhi Capitals vs Mumbai Indians',
    "date": "SUN, MAR 27 2022",
    "group": "Brabourne Stadium, Mumbai",
  },
  {
    "albumId": 1,
    "id": 3,
    "title": "Indian Premier League 2022",
    "teams": 'Gujarat Titans vs Lucknow Super Giants',
    "date": "MON, MAR 28 2022",
    "group": "Wankhede Stadium, Mumbai",
  },
  {
    "albumId": 1,
    "id": 4,
    "title": "Indian Premier League 2022",
    "teams": 'Sunrisers Hyderabad vs Rajasthan Royals',
    "date": "TUE, MAR 29 2022",
    "group": "Maharashtra Cricket Association Stadium, Pune",
  },
  {
    "albumId": 1,
    "id": 5,
    "title": "Indian Premier League 2022",
    "teams": 'Royal Challengers Bangalore vs Kolkata\n Knight Riders,',
    "date": "WED, MAR 30 2022",
    "group": "Dr DY Patil Sports Academy, Mumbai",
  },
  {
    "albumId": 1,
    "id": 6,
    "title": "Indian Premier League 2022",
    "teams": 'Lucknow Super Giants vs Chennai Super Kings',
    "date": "THU, MAR 31 2022",
    "group": "Brabourne Stadium, Mumbai",
  },
];

class UpcomingMatches extends StatefulWidget {
  const UpcomingMatches({Key? key}) : super(key: key);

  @override
  State<UpcomingMatches> createState() => _UpcomingMatchesState();
}

class _UpcomingMatchesState extends State<UpcomingMatches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedListView<dynamic, String>(
          elements: _Data,
          groupBy: (element) => element['date'],
          groupSeparatorBuilder: (groupByValue) => Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        groupByValue,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
          itemBuilder: (context, dynamic element) {
            return Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                element['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.sports_cricket_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text('${element['teams']}'),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text('${element['group']}'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemComparator: (item1, item2) =>
              item1['title'].compareTo(item2['title']),
          useStickyGroupSeparators: true, // optional
          floatingHeader: true, // optional
          order: GroupedListOrder.DESC),
    );
  }
}
