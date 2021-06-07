import 'package:flutter/material.dart';
import 'package:keleya_app/screens/login.dart';
import 'package:keleya_app/screens/sing-up.dart';
import 'package:keleya_app/services/helpers.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.title}) : super(key: null);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(PURPLE_MAIN),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(color: const Color(PURPLE_MAIN)),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(60),
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Text(
                      'Are you already a Keleya user?',
                      style: TextStyle(fontSize: 45, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 60),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(40),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(PURPLE_MAIN),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(createRoute(Login()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child:
                                    Text('Yes, log in with my Keleya details'),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(40),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(PURPLE_SECONDARY),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(createRoute(SingUp()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'No, create new account',
                                  style: TextStyle(
                                    color: const Color(PURPLE_MAIN),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
