class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String role;
  final String country;
  final int age;
  final String closeContactNumber;
  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.country,
    required this.age,
    required this.closeContactNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'country': country,
      'age': age,
      'closeContactNumber': closeContactNumber,
    };
  }

  @override
  String toString() {
    return '''RegisterRequestModel(name: $name, email: $email, password: $password, role: $role, country: $country, age: $age, closeContactNumber: $closeContactNumber)''';
  }
}
