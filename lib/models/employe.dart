class Employee {
  final String name;
  final String adresse;
  final String phone;

  // Constructor
  Employee({
    required this.name,
    required this.adresse,
    required this.phone,
  });

  // Factory method to create an Employee from a JSON object
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      adresse: json['adresse'],
      phone: json['phone'],
    );
  }

  // Method to convert an Employee instance into a JSON object
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
    return 'Employee(name: $name, adresse: $adresse, phone: $phone)';
  }
}
