import 'package:barber_shop/features/reservation/function.dart';
import 'package:barber_shop/models/client.dart';
import 'package:barber_shop/models/employe.dart';
import 'package:barber_shop/models/reservation.dart';
import 'package:barber_shop/models/service.dart';
import 'package:barber_shop/models/worktime.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({super.key});

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  DateTime selectedDay = DateTime.now();
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());

  final Worktime worktime = Worktime(
      startTimeMorning: "08:00",
      finalTimeMorning: "12:00",
      startTimeAfter: "14:00",
      finalTimeAfter: "18:00");

  List<String> availableTime = [];
  List<Reservation> reservations = [
    Reservation(
      dateReservation: DateTime(2024, 8, 30, 08, 00),
      dateCreation: DateTime(2023, 8, 30),
      services: [
        Service(name: "masque", duration: Duration(minutes: 50), price: 10)
      ],
      client: Client(
        name: "John",
        phone: "eee",
        adresse: "dd",
      ),
      employee: Employee(name: "name", adresse: "adresse", phone: '12345678'),
    ),
    Reservation(
      dateReservation: DateTime(2024, 8, 30, 11, 00),
      dateCreation: DateTime(2023, 8, 30),
      services: [
        Service(
            name: "coupe cheveux", duration: Duration(minutes: 20), price: 10)
      ],
      client: Client(
        name: "John",
        phone: "eee",
        adresse: "dd",
      ),
      employee: Employee(name: "name", adresse: "adresse", phone: '12345678'),
    ),
    Reservation(
      dateReservation: DateTime(2024, 9, 16, 8, 00),
      dateCreation: DateTime(2023, 8, 30),
      services: [
        Service(
            name: "coupe cheveux", duration: Duration(minutes: 20), price: 10)
      ],
      client: Client(
        name: "Cc",
        phone: "eee",
        adresse: "dd",
      ),
      employee: Employee(name: "name", adresse: "adresse", phone: '12345678'),
    ),
  ];

  List<Reservation> selectedDayReservations = [];
  List<String> availableSlots = [];

  @override
  void initState() {
    super.initState();
    _onDaySelected(selectedDay, selectedDay);
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
      selectedDayReservations = reservations.where((res) {
        return isSameDay(res.dateReservation, day);
      }).toList();
      availableTime = _getAvailableTimeForDay(day);
    });
  }

  List<String> _getAvailableTimeForDay(DateTime day) {
    availableSlots.clear();

    DateTime morningStart = _parseTime(day, worktime.startTimeMorning);
    DateTime morningEnd = _parseTime(day, worktime.finalTimeMorning);
    DateTime afternoonStart = _parseTime(day, worktime.startTimeAfter);
    DateTime afternoonEnd = _parseTime(day, worktime.finalTimeAfter);

    selectedDayReservations
        .sort((a, b) => a.dateReservation.compareTo(b.dateReservation));

    _checkAvailability(morningStart, morningEnd, availableSlots);

    _checkAvailability(afternoonStart, afternoonEnd, availableSlots);

    return availableSlots;
  }

  void _checkAvailability(
      DateTime start, DateTime end, List<String> availableSlots) {
    DateTime current = start;

    for (Reservation res in selectedDayReservations) {
      if (res.dateReservation.isBefore(end) &&
          res.getEndTime().isAfter(start)) {
        if (current.isBefore(res.dateReservation)) {
          availableSlots.add(
              "${DateFormat.Hm().format(current)} - ${DateFormat.Hm().format(res.dateReservation)}");
        }
        current = res.getEndTime();
      }
    }

    if (current.isBefore(end)) {
      availableSlots.add(
          "${DateFormat.Hm().format(current)} - ${DateFormat.Hm().format(end)}");
    }
  }

  DateTime _parseTime(DateTime day, String time) {
    final parsedTime = DateFormat.Hm().parse(time);
    return DateTime(
        day.year, day.month, day.day, parsedTime.hour, parsedTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: selectedDay,
          firstDay: DateTime(2024),
          lastDay: DateTime(2025),
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) {
            bool isSelected = isSameDay(day, selectedDay);
            bool isSunday = day.weekday == DateTime.sunday;
            return isSelected && !isSunday;
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (reservations
                  .any((res) => isSameDay(res.dateReservation, day))) {
                return const Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: 6.0,
                    height: 6.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
        Expanded(
          child: Wrap(
            children:
                availableTime.map((time) => Chip(label: Text(time))).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: selectedDayReservations.isEmpty
              ? const Center(child: Text('Aucune réservation pour cette date'))
              : ListView(
                  children: selectedDayReservations.map((reservation) {
                    int total = reservation.services.fold(
                        0,
                        (totalLength, element) =>
                            totalLength + element.duration.inMinutes);

                    return ListTile(
                      leading: Text(
                        Functions.formatDuration(total),
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      title: Text(
                        "${reservation.client.name} - ${reservation.services.map((service) => service.name).join(', ')}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${formatter.format(reservation.getEndTime())}"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        )
      ],
    );
  }
}
