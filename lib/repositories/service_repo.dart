import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barber_shop/models/service.dart';

class ServiceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addService(Service service) async {
    try {
      await _firestore.collection('services').add(service.toJson());
    } catch (e) {
      print('An error occurred while adding service: $e');
    }
  }

  Future<List<Service>> getAllServices() async {
    try {
      final snapshot = await _firestore.collection('services').get();
      return snapshot.docs.map((doc) => Service.fromJson(doc.data())).toList();
    } catch (e) {
      print('An error occurred while retrieving services: $e');
      return [];
    }
  }

  Future<double> getServiceByPrice(String service) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('services')
          .where('name', isEqualTo: service)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final serviceData = Service.fromJson(
            snapshot.docs.first.data() as Map<String, dynamic>);
        return serviceData.price.toDouble();
      } else {
        print('No service found with the name: $service');
      }
    } catch (e) {
      print('An error occurred while retrieving services: $e');
    }

    return 0.0;
  }
}
