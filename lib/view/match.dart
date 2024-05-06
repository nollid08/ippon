import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_list.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_tray.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key, required this.matchDoc});

  final QueryDocumentSnapshot<Map<String, dynamic>> matchDoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Match'),
        ),
        body: FutureBuilder(
          future: KumiteMatch.fromQueryDocument(matchDoc),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                final KumiteMatch match = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  match.title,
                                  style: GoogleFonts.roboto(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey[800],
                                      size: 20,
                                    ),
                                    Text(
                                      DateFormat.yMEd()
                                          .add_Hm()
                                          .format(match.dateTime),
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.grey[800],
                                      size: 20,
                                    ),
                                    Text(
                                      "Vs. ${match.opponent}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ScoreTray(match: match)
                              ]),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Scores',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ScoreList(match: match),
                    ],
                  ),
                );
              }
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading match! ${snapshot.error}'));
            }

            return const Center(child: Text('Error loading match'));
          },
        ));
  }
}
