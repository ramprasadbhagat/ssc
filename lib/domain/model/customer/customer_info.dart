class CustomerInfo {
  String name;
  String email;
  String password;
  String phoneNumber;
  String address;
  int id;
  String customerId;
  String cookie;

  CustomerInfo({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    this.id = -1,
    this.customerId = '',
    this.cookie = '',
  });

  factory CustomerInfo.empty() => CustomerInfo(
      address: '', email: '', name: '', password: '', phoneNumber: '');

  CustomerInfo copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    int? id,
    String? customerId,
    String? cookie,
  }) {
    return CustomerInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      cookie: cookie ?? this.cookie
    );
  }

  factory CustomerInfo.fromMap(Map<String, dynamic> map) {
    return CustomerInfo(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['mobileNo'] ?? '',
      address: map['address'] ?? '',
      id: map['id'],
      customerId: map['customerId'],
    );
  }

  // Method to convert a User to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'mobileNo': phoneNumber,
      'address': address,
      'id': id,
      'cookie': cookie,
    };
  }

  bool get isPhoneNumberPasswordEmpty => this.phoneNumber == CustomerInfo.empty().phoneNumber && this.password == CustomerInfo.empty().password && this.cookie == cookie;
}
