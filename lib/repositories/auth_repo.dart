import 'package:barber_shop/models/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> Login(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("User connected");
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("erreur in login : $e");
    } catch (e) {
      print('An unknown error occurred: $e');
    }
    return null;
  }

  String checkUser() {
    String? email = _auth.currentUser?.email;
    if (email != null) {
      print(email);
      return email;
    } else {
      return 'No email found';
    }
  }

  Future<List<Map<String, dynamic>>> getAllClients() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('clients').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'uid': doc.id,
          ...data,
        };
      }).toList();
    } catch (e) {
      print('An error occurred while fetching users: $e');
      return [];
    }
  }

  Future<bool> findClient(String phone) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('clients')
          .where('phone', isEqualTo: phone)
          .get();
      return (snapshot.docs.isEmpty) ? false : true;
    } catch (e) {
      print('An error occurred while fetching users: $e');
      return false;
    }
  }

  Future<bool> getClientOrCreate(String phone) async {
    try {
      bool isExist = await findClient(phone);
      if (!isExist) {
        await addClient(Client(name: "", adresse: "", phone: phone));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('An error occurred while fetching users: $e');
      return false;
    }
  }

  Future<void> addClient(Client client) async {
    try {
      await _firestore.collection('clients').add(client.toJson());
    } catch (e) {
      print('An error occurred while adding user: $e');
    }
  }
}
