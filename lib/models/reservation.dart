import 'package:barber_shop/models/client.dart';
import 'package:barber_shop/models/employe.dart';
import 'package:barber_shop/models/service.dart';
import 'package:barber_shop/models/user.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.Hm();

class Reservation {
  Reservation({
    required this.dateReservation,
    required this.dateCreation,
    required this.services,
    required this.client,
    required this.employee,
  }) : id = const Uuid().v4();

  final String id;
  final DateTime dateReservation;
  final DateTime dateCreation;
  final List<Service> services;
  final Client client;
  final Employee employee;

  String get formattedDate {
    return formatter.format(dateReservation);
  }

  DateTime getEndTime() {
    // Calculate the total duration of all services in minutes
    int total = services.fold(
        0, (totalLength, element) => totalLength + element.duration.inMinutes);

    // Return the calculated end time (reservation time + total duration)
    return dateReservation.add(Duration(minutes: total));
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      dateReservation: DateTime.parse(json['dateReservation']),
      dateCreation: DateTime.parse(json['dateCreation']),
      services: (json['services'] as List<dynamic>)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
      client: Client.fromJson(json['clients']),
      employee: Employee.fromJson(json['employees']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateReservation': dateReservation.toIso8601String(),
      'dateCreation': dateCreation.toIso8601String(),
      'services': services.map((service) => service.toJson()).toList(),
      'client': client.toJson(),
      'employee': employee.toJson(),
    };
  }
}
