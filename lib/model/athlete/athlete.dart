import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ippon/model/clubs/club.dart';

class Athlete {
  final String uid;
  final String name;

  Athlete({required this.uid, required this.name});

  Future<List<Club>> getClubs() async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> query = await db
        .collection('clubs')
        .where('athletes', arrayContains: uid)
        .get();
    final List<Club> clubs =
        query.docs.map((doc) => Club.fromDocumentSnapshot(doc)).toList();
    return clubs;
  }

  static Future<Athlete> create({required String name}) async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection('athletes').add({
      'name': name,
    });
    final athlete = Athlete(
      uid: doc.id,
      name: name,
    );
    return athlete;
  }

  static Future<Athlete> fromUid(String uid) async {
    final db = FirebaseFirestore.instance;
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await db.collection('athletes').doc(uid).get();
    final Athlete athlete = Athlete.fromDocumentSnapshot(doc);
    return athlete;
  }

  static Athlete fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    final athlete = Athlete(
      uid: doc.id,
      name: data['name'],
    );

    return athlete;
  }
}
