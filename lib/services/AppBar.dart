import 'package:flutter/material.dart';
import 'package:keleya_app/main.dart';
import 'package:keleya_app/services/helpers.dart';

AppBar getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: const Color(PURPLE_MAIN),
    ),
    actions: [
      IconButton(
          icon: Icon(Icons.logout),
          color: const Color(PURPLE_MAIN),
          onPressed: () {
            removeStorageKey("jwt");
            Navigator.of(context).push(createRoute(KeleyaApp()));
          }),
    ],
  );
}
