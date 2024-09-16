import 'package:uuid/uuid.dart';

class UserApp {
  UserApp({
    required this.username,
    required this.password,
    required this.phone,
    required this.address,
    required this.email,
  }) : id = const Uuid().v4();
  final String id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String address;
}
