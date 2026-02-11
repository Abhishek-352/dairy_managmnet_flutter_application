import 'package:dairy_managment/models/admin_farmer_management.dart';

class CustomerRepository {
  // Singleton pattern
  static final CustomerRepository _instance = CustomerRepository._internal();
  factory CustomerRepository() => _instance;
  CustomerRepository._internal();

  // In-memory storage (you can replace with database later)
  final List<Customer> _customers = [];

  // Get all customers
  List<Customer> getAllCustomers() {
    return List.unmodifiable(_customers);
  }

  // Get customer by serial number
  Customer? getCustomerBySerialNumber(String serialNumber) {
    try {
      return _customers.firstWhere(
        (customer) => customer.serialNumber == serialNumber,
      );
    } catch (e) {
      return null;
    }
  }

  // Add new customer
  bool addCustomer(Customer customer) {
    // Check if serial number already exists
    if (getCustomerBySerialNumber(customer.serialNumber) != null) {
      return false; // Serial number already exists
    }
    _customers.add(customer);
    return true;
  }

  // Update customer
  bool updateCustomer(String serialNumber, Customer updatedCustomer) {
    final index = _customers.indexWhere(
      (customer) => customer.serialNumber == serialNumber,
    );
    if (index != -1) {
      _customers[index] = updatedCustomer;
      return true;
    }
    return false;
  }

  // Delete customer
  bool deleteCustomer(String serialNumber) {
    final index = _customers.indexWhere(
      (customer) => customer.serialNumber == serialNumber,
    );
    if (index != -1) {
      _customers.removeAt(index);
      return true;
    }
    return false;
  }

  // Search customers by name
  List<Customer> searchCustomersByName(String query) {
    return _customers
        .where(
          (customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Get customers by milk type
  List<Customer> getCustomersByMilkType(String milkType) {
    return _customers
        .where((customer) => customer.milkType == milkType)
        .toList();
  }

  // Get total count
  int getTotalCustomers() {
    return _customers.length;
  }

  // Add sample data for testing
  void addSampleData() {
    _customers.clear();
    _customers.addAll([
      Customer(
        serialNumber: '001',
        name: 'Rajesh Kumar',
        milkType: 'Cow',
        phoneNumber: '9876543210',
        address: 'Village Rampur, Pune',
        registeredDate: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Customer(
        serialNumber: '002',
        name: 'Priya Sharma',
        milkType: 'Buffalo',
        phoneNumber: '9876543211',
        address: 'Village Shivaji Nagar, Pune',
        registeredDate: DateTime.now().subtract(const Duration(days: 25)),
      ),
      Customer(
        serialNumber: '003',
        name: 'Amit Patel',
        milkType: 'Cow',
        phoneNumber: '9876543212',
        address: 'Village Kharadi, Pune',
        registeredDate: DateTime.now().subtract(const Duration(days: 20)),
      ),
      Customer(
        serialNumber: '004',
        name: 'Sunita Desai',
        milkType: 'Buffalo',
        phoneNumber: '9876543213',
        address: 'Village Hadapsar, Pune',
        registeredDate: DateTime.now().subtract(const Duration(days: 15)),
      ),
      Customer(
        serialNumber: '005',
        name: 'Vikram Singh',
        milkType: 'Cow',
        phoneNumber: '9876543214',
        address: 'Village Wakad, Pune',
        registeredDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ]);
  }
}
