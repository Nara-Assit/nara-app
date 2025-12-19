class UserModel {
  final int id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String phoneNumber;
  final String createdAt;
  final bool isVerified;
  final String country;
  final int age;
  final String closeContactNumber;
  final String lastActiveAt;
  final String role;
  const UserModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.isVerified,
    required this.country,
    required this.age,
    required this.closeContactNumber,
    required this.lastActiveAt,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? '',
      createdAt: json['createdAt'],
      isVerified: json['isVerified'],
      country: json['country'],
      age: json['age'],
      closeContactNumber: json['closeContactNumber'],
      lastActiveAt: json['lastActiveAt'] ?? '',
      role: json['role'],
    );
  }

  @override
  String toString() {
    return '''UserModel(id: $id, name: $name, profileImageUrl: $profileImageUrl, email: $email, phoneNumber: $phoneNumber, createdAt: $createdAt, isVerified: $isVerified, country: $country, age: $age, closeContactNumber: $closeContactNumber, role: $role)''';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'isVerified': isVerified,
      'country': country,
      'age': age,
      'closeContactNumber': closeContactNumber,
      'lastActiveAt': lastActiveAt,
      'role': role,
    };
  }
}
