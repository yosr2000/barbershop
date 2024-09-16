import 'package:uuid/uuid.dart';

class Worktime {
  Worktime({
    required this.startTimeMorning,
    required this.finalTimeMorning,
    required this.startTimeAfter,
    required this.finalTimeAfter,
  }) : id = const Uuid().v4();
  final String id;
  final String startTimeMorning;
  final String finalTimeMorning;
  final String startTimeAfter;
  final String finalTimeAfter;
}
