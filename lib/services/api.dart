import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:keleya_app/models/user.dart';
import 'package:keleya_app/services/helpers.dart';

const SERVER_URL = 'http://localhost:3000/api/users';

Future<User> getUserFromResponse(String responseBody) async {
  Map<String, dynamic> response = jsonDecode(responseBody);
  var jwt = response['token'];
  saveStorageKey("jwt", jwt);

  return User.fromJWT(jwt);
}

Future<User?> attemptLogIn(String username, String password) async {
  var res = await http.post(Uri.parse("$SERVER_URL/auth"),
      body: {"email": username, "password": password});
  if (res.statusCode == 200) {
    return getUserFromResponse(res.body);
  }

  return null;
}

Future<User?> attemptSingUp(String username, String password) async {
  var res = await http.post(Uri.parse(SERVER_URL), body: {
    "email": username,
    "password": password,
    "accepted_privacy_policy": "true",
    "accepted_terms_and_conditions": "true",
  });

  if (res.statusCode == 201) {
    return getUserFromResponse(res.body);
  }

  return null;
}

Future<User?> attemptUpdateUser(User user) async {
  String? token = await readStorageKey('jwt');
  var res = await http.patch(Uri.parse(SERVER_URL), headers: {
    "Authorization": token.toString()
  }, body: {
    "name": user.name == null ? '' : user.name,
    "baby_birth_date":
        user.babyBirthDate == null ? '' : user.babyBirthDate.toString()
  });

  if (res.statusCode == 200) {
    return getUserFromResponse(res.body);
  }

  return null;
}
