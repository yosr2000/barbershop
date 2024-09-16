// enum Name {
//   coupeCheveux,
//   masque,
//   rasage,
// }

// get staticService => Service(
//     name: Name.coupeCheveux, duration: Duration(minutes: 50), price: 10.0);
// get staticService2 =>
//     Service(name: Name.masque, duration: Duration(minutes: 50), price: 5.0);

class Service {
  Service({required this.name, required this.duration, required this.price});

  final String name;
  final Duration duration;
  final double price;
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      duration: Duration(minutes: json['duration']),
      price: json['price'].toDouble(), // S'assurez que c'est bien un double
    );
  }

  // Method to convert an Employee instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration.inMinutes,
      'price': price,
    };
  }
}
