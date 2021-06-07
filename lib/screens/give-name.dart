import 'package:flutter/material.dart';
import 'package:keleya_app/models/user.dart';
import 'package:keleya_app/screens/more-data.dart';
import 'package:keleya_app/services/AppBar.dart';
import 'package:keleya_app/services/api.dart';
import 'package:keleya_app/services/helpers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GiveName extends StatefulWidget {
  GiveName(this.user);
  final User user;

  @override
  _GiveName createState() => _GiveName();
}

class _GiveName extends State<GiveName> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(60),
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Text(
                      'What should we call you?',
                      style: TextStyle(fontSize: 45),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Container(
              margin:
                  const EdgeInsets.only(right: 20, top: 0, left: 20, bottom: 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Your name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(PURPLE_MAIN),
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                          ),
                          onPressed: () async {
                            EasyLoading.show();
                            User user = widget.user;
                            if (_formKey.currentState!.validate()) {
                              var name = _nameController.text;
                              if (name != '') {
                                user.name = name;
                                var updatedUser = await attemptUpdateUser(user);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MoreData(updatedUser!)));
                              }
                            }
                          },
                          child: Text('Next question'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
