import 'dart:convert';
import 'package:fluitter_machine_test/components/utils.dart';
import 'package:flutter/cupertino.dart';
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

  LoginModel? loginModel;




  Future<String?> userSignIn(String email, String password, BuildContext context) async {
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/login"));
    request.fields.addAll({'email': email, 'password': password});

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var finalResult = jsonDecode(result);
        String token = finalResult['token']; // Assuming your response contains a token
        Utils.mySnackBar(context, title: '${finalResult['message']}');
        return token;
      } else {
        var errorResult = await response.stream.bytesToString();
        var finalResult = jsonDecode(errorResult);
        Utils.mySnackBar(context, title: '${finalResult['message']}');
        return null;
      }
    } catch (e) {
      print('Error signing in: $e');
      Fluttertoast.showToast(msg: 'Failed to sign in. Please try again.');
      return null;
    }
  }


  // Future<String?> userSignIn(String email, String password, BuildContext context) async {
  //   var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$login"));
  //   request.fields.addAll({'email': email, 'password': password});
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(result);
  //     String token = finalResult['token']; // Assuming your response contains a token
  //     Utils.mySnackBar(context, title: '${finalResult['message']}');
  //     return token;
  //   } else {
  //     var errorResult = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(errorResult);
  //     Utils.mySnackBar(context, title: '${finalResult['message']}');
  //     return null;
  //   }
  // }

  /// Signin api
  // Future<LoginModel?> userSignIn(String email, String password, context) async {
  //   var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$login"));
  //   request.fields.addAll({'email': email, 'password': password});
  //   http.StreamedResponse response = await request.send();
  //   debugPrint("status code : ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(result);
  //     debugPrint("log in response : $finalResult");
  //     loginModel = LoginModel.fromJson(finalResult);
  //     Utils.mySnackBar(context, title: '${finalResult['message']}');
  //   } else {
  //     var errorResult = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(errorResult);
  //     Utils.mySnackBar(context, title: '${finalResult['message']}');
  //     debugPrint(response.reasonPhrase);
  //   }
  //   return loginModel;
  // }

  /// Signup api
  Future<void> userSignUp(
      String firstName,
      String? lastName,
      String? email,
      String password,
      String? confirmPassword,
      String? countryCode,
      String? phoneNumber,

      BuildContext context) async {
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$signup"));
    request.fields.addAll({
      'first_name': firstName,
      'last_name': lastName.toString(),
      'email': email.toString(),
      'password': password,
      'confirm_password': confirmPassword.toString(),
      'country_code': countryCode.toString(),
      'phone_no': phoneNumber.toString()

    });
    http.StreamedResponse response = await request.send();
    debugPrint("status code : ${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      debugPrint("sign up response : $finalResult");
      if (finalResult['error'] == false) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        preferences.setString("userId", finalResult['data']['id'] ?? "");
        preferences.setString(
            "userName", finalResult['data']['username'] ?? "");
        preferences.setString("userEmail", finalResult['data']['email'] ?? "");
        Navigator.pushNamed(context, '/'); // Navigate to home screen
        Utils.mySnackBar(context, title: '${finalResult['message']}');
      } else {
        Utils.mySnackBar(context, title: '${finalResult['message']}');
      }
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  /// Get Data
  Future<void> getUserList(
      String mobile, String password, audioController, context) async {
    var headers = {'Cookie': 'ci_session=c7797mp92d9k6gmq38epdr8hm70h9vab'};
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$signup"));
    request.fields.addAll({'mobile': mobile, 'password': password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    debugPrint("status code : ${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        preferences.setString("userId", finalResult['data']['id'] ?? "");
        preferences.setString(
            "userName", finalResult['data']['username'] ?? "");
        preferences.setString("userEmail", finalResult['data']['email'] ?? "");
      } else {
        Utils.mySnackBar(context, title: '${finalResult['message']}');
      }
    } else {
      debugPrint(response.reasonPhrase);
    }
  }
}
