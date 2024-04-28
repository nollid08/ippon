import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'match.dart';

class Matchbook extends StatefulWidget {
  const Matchbook({super.key});

  @override
  State<Matchbook> createState() => _MatchbookState();
}

class _MatchbookState extends State<Matchbook> {
  @override
  void initState() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    stream = db
        .collection('users')
        .doc('gBONifqYDpc0fUlRrEE025mJ92m1')
        .collection('matches')
        .snapshots();
    super.initState();
  }

  @override
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Book'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_alt,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final matches = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    try {
                      final match = matches[index];
                      final String title = match['title'];
                      final String description = match['description'];
                      final String opponent = match['opponent'];
                      return ListTile(
                          title: Text('$title vs $opponent'),
                          subtitle: Text(description),
                          onTap: () => {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: Match(
                                      title: title,
                                      description: description,
                                      opponent: opponent,
                                      wasWon: true),
                                  withNavBar: true,
                                )
                              });
                    } catch (e) {
                      return const Center(child: Text('Error loading matches'));
                    }
                  });
            } else {
              return const Center(child: Text('No matches found'));
            }
          }),
    );
  }
}
