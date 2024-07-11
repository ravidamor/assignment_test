import 'dart:convert';
import 'package:fluitter_machine_test/components/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import 'api_end_points.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  final String baseUrl = Endpoints.baseUrl;
  final String login = Endpoints.login;
  final String signup = Endpoints.signup;
  final String logoutUrl = Endpoints.logout;
  static String loginToken = "";

  LoginModel? loginModel;

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginToken', token);
  }

  Future<String?> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginToken');
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginToken');
  }

  /// Signin api
  Future<String?> userSignIn(
      String email, String password, BuildContext context) async {
    var url = Uri.parse('$baseUrl$login');
    var response;

    try {
      response = await http.post(
        url,
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        String token = result['record']
            ['authtoken']; // Assuming your response contains a token
        if (token.isNotEmpty) {
          loginToken = token;
          _storeToken(token); // Store the token in SharedPreferences
          // Optionally, fetch and store user details here
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isLoggedIn", true);
          preferences.setString("userId", result['record']['id'].toString());
          preferences.setString(
              "profileImg", result['record']['profileImg'].toString());
          preferences.setString("userName",
              '${result['record']['firstName']} ${result['record']['lastName']}');
          preferences.setString("userEmail", result['record']['email']);
          Navigator.pushReplacementNamed(
              context, '/home'); // Navigate to home screen
          Utils.mySnackBar(context, title: '${result['message']}');
        }

        return token;
      } else {
        var errorResult = jsonDecode(response.body);
        Utils.mySnackBar(context, title: '${errorResult['message']}');
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
      Fluttertoast.showToast(msg: 'Failed to sign in. Please try again.');
      return null;
    }
  }

  // (email, password,firstName,lastName, countryCode,phoneNumber,confirmPassword,context)

  /// Signup api
  Future<void> userSignUp(
      {email,
      password,
      firstName,
      lastName,
      countryCode,
      phoneNumber,
      confirmPassword,
      context}) async {
    var url = Uri.parse('$baseUrl$signup');
    var response;

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        'first_name': firstName,
        'last_name': lastName ?? '',
        'email': email ?? '',
        'password': password,
        'confirm_password': confirmPassword ?? '',
        'country_code': countryCode ?? '',
        'phone_no': phoneNumber ?? '',
      });

      response = await request.send();

      if (response.statusCode == true) {
        var result = await response.stream.bytesToString();
        var finalResult = jsonDecode(result);
        debugPrint("Sign-up response: $finalResult");

        if (!finalResult['error']) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isLoggedIn", true);
          preferences.setString("userId", finalResult['data']['id'] ?? "");
          preferences.setString("userName", finalResult['data']['username'] ?? "");
          preferences.setString("userEmail", finalResult['data']['email'] ?? "");
          Navigator.pushNamed(context, '/'); // Navigate to home screen
          Utils.mySnackBar(context, title: '${finalResult['message']}');
        } else {
          Utils.mySnackBar(context, title: '${finalResult['message']}');
        }
      } else {
        debugPrint('Sign-up failed: ${response.reasonPhrase}');
        Fluttertoast.showToast(msg: 'Failed to sign up. Please try again.');
      }
    } catch (e) {
      print('Error signing up: $e');
      Fluttertoast.showToast(msg: 'Failed to sign up. Please try again.');
    }
  }

  ///logout

  Future<void> logout(BuildContext context) async {
    var url = Uri.parse('$baseUrl$logoutUrl');
    final prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('loginToken')}',
        },
      );

      if (response.statusCode == 200) {
        // Clear token from SharedPreferences
        await _clearToken();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", false);
        preferences.remove("userId");
        preferences.remove("userName");
        preferences.remove("userEmail");

        // Navigate to login screen
        Navigator.pushReplacementNamed(context, '/login');
        Utils.mySnackBar(context, title: 'Logged out successfully');
      } else {
        var errorResult = jsonDecode(response.body);
        Utils.mySnackBar(context, title: '${errorResult['message']}');
      }
    } catch (e) {
      print('Error logging out: $e');
      Fluttertoast.showToast(msg: 'Failed to log out. Please try again.');
    }
  }
}
