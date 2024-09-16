class Functions {
  static String formatDuration(int totalMinutes) {
    int hours = totalMinutes ~/ 60; // Integer division to get hours
    int minutes = totalMinutes % 60; // Remainder to get remaining minutes

    String hoursText = hours > 0 ? '${hours}h' : '';
    String minutesText = minutes > 0 ? '${minutes}mn' : '';

    return '$hoursText ${minutesText}'
        .trim(); // Combine and trim any leading/trailing spaces
  }
}
