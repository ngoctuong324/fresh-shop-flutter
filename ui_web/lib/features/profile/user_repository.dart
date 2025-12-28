import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<String?> getPhone() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _db.collection('users').doc(user.uid).get();
    if (doc.exists && doc.data() != null) {
      return doc.data()!['phoneNumber'] as String?;
    }
    return null;
  }

  Future<void> updateProfile(String name, String phone) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);

      await _db.collection('users').doc(user.uid).set({
        'displayName': name,
        'phoneNumber': phone,
        'email': user.email,
      }, SetOptions(merge: true));

      await user.reload();
    }
  }
}
