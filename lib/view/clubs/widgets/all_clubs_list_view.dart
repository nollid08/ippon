import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ippon/model/clubs/club.dart';

class AllClubsListView extends StatelessWidget {
  const AllClubsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Club>>(
      stream: Club.getAllClubsAsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Club> clubs = snapshot.data!;
          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              Club club = clubs[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 2),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        club.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(club.description ?? ''),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle join button press
                            final user = FirebaseAuth.instance.currentUser;
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please sign in to join a club'),
                                ),
                              );
                              return;
                            }
                            club.addMember(user.uid);
                          },
                          child: Text('Join'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
