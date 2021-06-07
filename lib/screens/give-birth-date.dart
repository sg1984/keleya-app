import 'package:flutter/material.dart';
import 'package:keleya_app/models/user.dart';
import 'package:keleya_app/screens/more-data.dart';
import 'package:keleya_app/services/AppBar.dart';
import 'package:keleya_app/services/api.dart';
import 'package:keleya_app/services/helpers.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GiveBirthDate extends StatefulWidget {
  GiveBirthDate(this.user);
  final User user;

  @override
  _GiveBirthDate createState() => _GiveBirthDate();
}

class _GiveBirthDate extends State<GiveBirthDate> {
  final TextEditingController _birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _birthDateController.text = formatter.format(picked);
    }
  }

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
                      'When was your baby born?',
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
                    Container(
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(60),
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              'This well help us give you relevant tips to car for yourself & your baby',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          onTap: () => _selectDate(context),
                          controller: _birthDateController,
                          decoration: InputDecoration(labelText: 'Birth date'),
                        ),
                      ),
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
                              user.babyBirthDate = selectedDate;
                              var updatedUser = await attemptUpdateUser(user);
                              if (updatedUser != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MoreData(updatedUser)));
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
