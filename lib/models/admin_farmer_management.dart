class Customer {
  final String serialNumber;
  final String name;
  final String milkType; // 'Cow' or 'Buffalo'
  final String phoneNumber;
  final String address;
  final DateTime registeredDate;

  Customer({
    required this.serialNumber,
    required this.name,
    required this.milkType,
    required this.phoneNumber,
    required this.address,
    required this.registeredDate,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'serialNumber': serialNumber,
      'name': name,
      'milkType': milkType,
      'phoneNumber': phoneNumber,
      'address': address,
      'registeredDate': registeredDate.toIso8601String(),
    };
  }

  // Create from Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      serialNumber: map['serialNumber'] ?? '',
      name: map['name'] ?? '',
      milkType: map['milkType'] ?? 'Cow',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      registeredDate: DateTime.parse(map['registeredDate']),
    );
  }

  // Copy with method for updates
  Customer copyWith({
    String? serialNumber,
    String? name,
    String? milkType,
    String? phoneNumber,
    String? address,
    DateTime? registeredDate,
  }) {
    return Customer(
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      milkType: milkType ?? this.milkType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      registeredDate: registeredDate ?? this.registeredDate,
    );
  }
}
