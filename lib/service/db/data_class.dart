class UserObject {
  final String firstName;
  final String lastName;
  final String? email; //? means nullable

  UserObject({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory UserObject.fromJson(Map<String, dynamic> json) {
    return UserObject(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
