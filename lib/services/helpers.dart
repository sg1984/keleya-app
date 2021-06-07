import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:keleya_app/main.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

Route createRoute(action) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => action,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void saveStorageKey(String key, String value) async {
  if (!kIsWeb) {
    storage.write(key: key, value: value);
  } else {
    final Storage _localStorage = window.localStorage;
    _localStorage[key] = value;
  }
}

Future<String?> readStorageKey(String key) async {
  if (!kIsWeb) {
    return await storage.read(key: key);
  } else {
    final Storage _localStorage = window.localStorage;
    return _localStorage.containsKey(key) ? _localStorage[key] : null;
  }
}

void removeStorageKey(String key) async {
  if (!kIsWeb) {
    storage.delete(key: key);
  } else {
    final Storage _localStorage = window.localStorage;
    _localStorage[key] = '';
  }
}

String getErrorMessage(String errorCode) {
  Map<String, String> errorList = {
    'EMAIL_REGISTERED': 'Email already registered.',
    'NO_ACCOUNT_FIND': 'No account was found matching that email and password',
  };

  return errorList.containsKey(errorCode)
      ? errorList[errorCode].toString()
      : 'Unidentified error';
}

const PURPLE_MAIN = 0xff5a4fd9;
const PURPLE_SECONDARY = 0xfff3ecff;
