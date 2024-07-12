import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Api Services/requests.dart';
import '../models/user_model.dart';

class LoginController with ChangeNotifier {
  final UserModel _user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    phoneNumber: '',
    countryCode: '',
    confirmPassword: '',
  );

  bool _isLoadingSignUp = false;
  bool _isLoading = false;

  bool get isLoadingSignUp => _isLoadingSignUp;



  set isLoadingSignUp(bool value) {
    _isLoadingSignUp = value;
    notifyListeners();
  }
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get email => _user.email;

  String get password => _user.password;

  String? get phoneNumber => _user.phoneNumber;

  String? get firstName => _user.firstName;

  String? get lastName => _user.lastName;

  String? get confirmPassword => _user.confirmPassword;

  String? get countryCode => _user.countryCode;

  set email(String value) {
    _user.email = value;
    notifyListeners();
  }

  set password(String value) {
    _user.password = value;
    notifyListeners();
  }

  set phoneNumber(String? value) {
    _user.phoneNumber = value;
    notifyListeners();
  }

  set firstName(String? value) {
    _user.firstName = value;
    notifyListeners();
  }

  set lastName(String? value) {
    _user.lastName = value;
    notifyListeners();
  }

  set countryCode(String? value) {
    _user.countryCode = value;
    notifyListeners();
  }

  set confirmPassword(String? value) {
    _user.confirmPassword = value;
    notifyListeners();
  }

  bool validateEmail() {
    if (_user.email.isEmpty || !_user.email.contains('@')) {
      Fluttertoast.showToast(msg: 'Enter a valid email');
      return false;
    }
    return true;
  }

  bool validatePassword() {
    if (_user.password.isEmpty || _user.password.length < 6) {
      Fluttertoast.showToast(msg: 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  bool validateSignUpFields() {
    if (_user.firstName == null || _user.firstName!.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter a valid first name');
      return false;
    }
    if (_user.lastName == null || _user.lastName!.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter a valid last name');
      return false;
    }
    if (_user.phoneNumber == null ||
        _user.phoneNumber!.isEmpty ||
        _user.phoneNumber!.length < 10) {
      Fluttertoast.showToast(msg: 'Enter a valid phone number');
      return false;
    }
    if (_user.countryCode == null || _user.countryCode!.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter a valid country code');
      return false;
    }
    if (_user.confirmPassword == null || _user.confirmPassword!.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter a valid confirm Password');
      return false;
    }

    return true;
  }

  Future<void> userSignIn(BuildContext context) async {
    if (validateEmail() && validatePassword()) {
      isLoading = true;
      try {
        await ApiRequests().userSignIn(email, password, context);
      } finally {
        isLoading = false;
      }
    }
  }

  Future<void> userSignUp(BuildContext context) async {
    if (validateEmail() && validatePassword() && validateSignUpFields()) {
      isLoadingSignUp = true;
      try {
        await ApiRequests().userSignUp(
            email: email,
            password: password,
            firstName: firstName.toString(),
            lastName: lastName!,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            confirmPassword: confirmPassword,
            context: context);
        Navigator.pushReplacementNamed(context, '/login');
      } finally {
        isLoadingSignUp = false;
      }
    }
  }
}
