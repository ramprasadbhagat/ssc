class EngineerInfo {
  String name;
  String id;
  String password;
  String phoneNumber;
  String address;
  double rating;

  EngineerInfo({
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.rating,
    required this.id,
  });

  factory EngineerInfo.empty() => EngineerInfo(
      address: '', name: '', password: '', phoneNumber: '', rating: 0, id: '');

  EngineerInfo copyWith({
    String? name,
    String? password,
    String? phoneNumber,
    String? address,
    double? rating,
    String? id,
  }) {
    return EngineerInfo(
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      id: id ?? this.id,
    );
  }
}