import 'package:bangla_book/antities/football.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FootBallScoreCard extends StatefulWidget {
  const FootBallScoreCard({super.key});

  @override
  State<FootBallScoreCard> createState() => _FootBallScoreCardState();
}

class _FootBallScoreCardState extends State<FootBallScoreCard> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Football> matchList = [];



  Future<void> _getFootballMatches() async {
    matchList.clear();
    final QuerySnapshot result =
        await firebaseFirestore.collection('football').get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        Football(
          matchName: doc.id,
          team1Name: doc.get('team1Name'),
          team2Name: doc.get('team2Name'),
          team1Score: doc.get('team1'),
          team2Score: doc.get('team2'),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFootballMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: matchList.length,
        itemBuilder: (context, index) {
          return FootballScoreCard(
            football: matchList[index],
          );
        },
      ),
    );
  }
}

class FootballScoreCard extends StatelessWidget {
  const FootballScoreCard({
    super.key,
    required this.football,
  });

  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeam(football.team1Name, football.team1Score),
            Text(
              'vs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            _buildTeam(football.team2Name, football.team2Score),
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(String teamName, int score) {
    return Column(
      children: [
        Text(
          score.toString(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Text(
          teamName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
