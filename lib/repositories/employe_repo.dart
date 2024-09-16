import 'package:barber_shop/models/employe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Employee>> getAllEmployees() async {
    try {
      final snapshot = await _firestore.collection('employees').get();
      return snapshot.docs.map((doc) => Employee.fromJson(doc.data())).toList();
    } catch (e) {
      print('An error occurred while retrieving employees: $e');
      return [];
    }
  }
}
