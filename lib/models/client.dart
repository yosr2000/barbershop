class Client {
  final String name;
  final String adresse;
  final String phone;

  // Constructor
  Client({
    required this.name,
    required this.adresse,
    required this.phone,
  });

  // Factory method to create an Client from a JSON object
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      adresse: json['adresse'],
      phone: json['phone'],
    );
  }

  // Method to convert an Client instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'adresse': adresse,
      'phone': phone,
    };
  }

  // Optional: Override toString for easier debugging and logging
  @override
  String toString() {
    return 'Client(name: $name, adresse: $adresse, phone: $phone)';
  }
}
