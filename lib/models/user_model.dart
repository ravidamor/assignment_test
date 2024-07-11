class UserModel {
  String email;
  String password;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? confirmPassword;

  UserModel({
    required this.email,
    required this.password,
    this.phoneNumber,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.confirmPassword,

  });
}
