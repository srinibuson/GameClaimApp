// services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _likedRef {
    final uid = _auth.currentUser!.uid;
    return _db.collection('users').doc(uid).collection('liked_giveaways');
  }

  // Toggle like/unlike — returns new state
  Future<bool> toggleLike(Map<String, dynamic> gameData) async {
    final id = gameData['id'].toString();
    final doc = _likedRef.doc(id);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.delete();
      return false; // unliked
    } else {
      await doc.set({
        'id': gameData['id'],
        'title': gameData['title'],
        'thumbnail': gameData['thumbnail'],
        'image': gameData['image'],
        'description': gameData['description'],
        'platforms': gameData['platforms'],
        'end_date': gameData['end_date'],
        'type': gameData['type'],
        'worth': gameData['worth'],
        'status': gameData['status'],
        'users': gameData['users'],
        'open_giveaway': gameData['open_giveaway'],
        'liked_at': FieldValue.serverTimestamp(),
      });
      return true; // liked
    }
  }

  // Check single item
  Future<bool> isLiked(int id) async {
    final doc = await _likedRef.doc(id.toString()).get();
    return doc.exists;
  }

  // Stream liked IDs — for heart state on cards
  Stream<Set<int>> likedIdsStream() {
    return _likedRef.snapshots().map(
      (snap) => snap.docs.map((d) => d['id'] as int).toSet(),
    );
  }

  // Stream full liked items — for Favourites tab
  Stream<List<Map<String, dynamic>>> likedItemsStream() {
    return _likedRef
        .orderBy('liked_at', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}
