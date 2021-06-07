import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keleya_app/screens/login.dart';
import 'package:keleya_app/screens/more-data.dart';
import 'package:keleya_app/services/api.dart';
import 'package:keleya_app/services/helpers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SingUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(PURPLE_MAIN),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: SingUpForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class SingUpForm extends StatefulWidget {
  @override
  _SingUpForm createState() => _SingUpForm();
}

class _SingUpForm extends State<SingUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool privacyPolicy = false;
  bool termsConditions = false;

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
                  'Welcome to Keleya Mama',
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!isEmailValid(value)) {
                                return 'Please enter an valid email';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter enter the same password';
                              }
                              if (value != _passwordController.text) {
                                return 'Confirm Passwords don\'t match';
                              }
                              return null;
                            },
                            controller: _confirmPassController,
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(PURPLE_MAIN),
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 30),
                                ),
                                onPressed: (termsConditions && privacyPolicy)
                                    ? () async {
                                        EasyLoading.show();
                                        var username = _emailController.text;
                                        var password = _passwordController.text;
                                        var user = await attemptSingUp(
                                            username, password);
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
                                            content: Text(getErrorMessage(
                                                'EMAIL_REGISTERED')),
                                          ));
                                        }
                                      }
                                    : null,
                                child: Text('Create an account'),
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            title: Text("I accept the privacy policy"),
                            value: privacyPolicy,
                            onChanged: (newValue) {
                              setState(() {
                                privacyPolicy =
                                    newValue == null ? false : newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            title: Text(
                                "I accept the terms & conditions & Keleya's advice"),
                            value: termsConditions,
                            onChanged: (newValue) {
                              setState(() {
                                termsConditions =
                                    newValue == null ? false : newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sing In',
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login())),
                                      style: new TextStyle(
                                        color: const Color(PURPLE_MAIN),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
