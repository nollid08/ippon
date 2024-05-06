import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ippon/model/athlete/athlete.dart';
import 'package:ippon/model/clubs/club_types.dart';

class Club {
  final String uid;
  final String name;
  final String? description;
  final ClubTypes type;

  Club({
    required this.uid,
    required this.type,
    required this.name,
    required this.description,
  });

  static Future<Club> create({
    required String name,
    required ClubTypes type,
    String? description,
  }) async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection('clubs').add({
      'name': name,
      'type': type.index,
      'description': description,
    });
    final club = Club(
      uid: doc.id,
      name: name,
      type: type,
      description: description,
    );
    return club;
  }

  static Future<Club> fromUid(String uid) async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection('clubs').doc(uid).get();
    final data = doc.data()!;

    final club = Club(
      uid: doc.id,
      name: data['name'],
      type: ClubTypes.values[data['type']],
      description: data['description'],
    );
    return club;
  }

  static Future<Club> fromDocumentReference(
      DocumentReference<Map<String, dynamic>> documentSnapshot) async {
    final doc = await documentSnapshot.get();
    final data = doc.data()!;

    final club = Club.fromDocumentSnapshot(doc);
    return club;
  }

  static Club fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    final club = Club(
      uid: doc.id,
      name: data['name'],
      type: ClubTypes.values[data['type']],
      description: data['description'],
    );
    return club;
  }

  static Future<List<Club>> getAllClubs() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('clubs').get();
    final clubs = snapshot.docs.map((doc) {
      return fromDocumentSnapshot(doc);
    }).toList();
    return clubs;
  }

  static Stream<List<Club>> getAllClubsAsStream() {
    final db = FirebaseFirestore.instance;
    final snapshot = db.collection('clubs').snapshots();
    return snapshot.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return fromDocumentSnapshot(doc);
      }).toList();
    });
  }

  Future<void> addMember(String uid) async {
    final db = FirebaseFirestore.instance;
    final userDoc = db.collection('users').doc(uid);
    await userDoc.update({
      'clubs': FieldValue.arrayUnion([this.uid]),
    });
  }

  Future<void> removeMember(String uid) async {
    final db = FirebaseFirestore.instance;
    final userDoc = db.collection('users').doc(uid);
    await userDoc.update({
      'clubs': FieldValue.arrayRemove([this.uid]),
    });
  }

  Future<List<Athlete>> getMembers() async {
    final db = FirebaseFirestore.instance;
    final snapshot =
        await db.collection('users').where('clubs', arrayContains: uid).get();
    final members = snapshot.docs.map((doc) {
      return Athlete.fromDocumentSnapshot(doc);
    }).toList();
    return members;
  }

  Stream<List<Athlete>> getMembersAsStream() {
    final db = FirebaseFirestore.instance;
    final snapshot =
        db.collection('users').where('clubs', arrayContains: uid).snapshots();
    return snapshot.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Athlete.fromDocumentSnapshot(doc);
      }).toList();
    });
  }
}
