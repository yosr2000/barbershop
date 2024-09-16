import 'package:barber_shop/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Reservation>> getReservationsByDate(
      DateTime date, String employeeName) async {
    try {
      final snapshot = await _firestore
          .collection('reservations')
          .where('date', isEqualTo: date)
          .where('name', isEqualTo: employeeName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final List<Reservation> reservations = snapshot.docs.map((doc) {
          return Reservation.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return reservations;
      } else {
        print("Pas de réservation pour cette date");
        return [];
      }
    } catch (e) {
      print("Erreur lors de la récupération des réservations: $e");
      return [];
    }
  }

  Future<List<Reservation>> getAllReservations() async {
    try {
      final snapshot = await _firestore.collection('reservations').get();
      return snapshot.docs
          .map((doc) => Reservation.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('An error occurred while retrieving reservations: $e');
      return [];
    }
  }

  Future<void> addReservation(Reservation reservation) async {
    try {
      await _firestore.collection('reservations').add(reservation.toJson());
    } catch (e) {
      print('An error occurred while adding reservation: $e');
    }
  }
}
