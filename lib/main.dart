import 'package:flutter/material.dart';
import 'package:keleya_app/models/user.dart';
import 'package:keleya_app/screens/home-page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:keleya_app/screens/more-data.dart';
import 'package:keleya_app/services/helpers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final storage = FlutterSecureStorage();
const APP_TITLE = 'Keleya Challenge App';

void main() {
  runApp(KeleyaApp());
}

class KeleyaApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await readStorageKey("jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (snapshot.data != "") {
            var str = snapshot.data.toString();
            var jwt = str.split(".");
            if (jwt.length != 3) {
              HomePage(title: APP_TITLE);
            } else {
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                  .isAfter(DateTime.now())) {
                User user = User.fromJWT(str);
                return MoreData(user);
              } else {
                return HomePage(title: APP_TITLE);
              }
            }
          }
          return HomePage(title: APP_TITLE);
        },
      ),
    );
  }
}
