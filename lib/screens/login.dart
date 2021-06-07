import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keleya_app/screens/more-data.dart';
import 'package:keleya_app/services/api.dart';
import 'package:keleya_app/services/helpers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(PURPLE_MAIN),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(color: const Color(PURPLE_MAIN)),
          child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(60),
                padding: const EdgeInsets.only(bottom: 80),
                child: Text(
                  'Great to have you back!',
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
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 20, top: 0, left: 20, bottom: 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sing in using your Keleya account info',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (!isEmailValid(value)) {
                              return 'Please enter an valid email';
                            }
                            return null;
                          },
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                text: 'Forgot your password?',
                                style: new TextStyle(
                                    color: const Color(PURPLE_MAIN)),
                                recognizer: new TapGestureRecognizer(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(PURPLE_MAIN),
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                              ),
                              onPressed: () async {
                                EasyLoading.show();
                                if (_formKey.currentState!.validate()) {
                                  var username = _usernameController.text;
                                  var password = _passwordController.text;
                                  var user =
                                      await attemptLogIn(username, password);
                                  if (user != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MoreData(user)));
                                  } else {
                                    EasyLoading.dismiss();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          getErrorMessage('NO_ACCOUNT_FIND')),
                                    ));
                                  }
                                }
                              },
                              child: Text('Sing in'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
