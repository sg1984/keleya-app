import 'package:flutter/material.dart';
import 'package:keleya_app/models/user.dart';
import 'package:keleya_app/screens/give-birth-date.dart';
import 'package:keleya_app/screens/give-name.dart';
import 'package:keleya_app/services/AppBar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MoreData extends StatefulWidget {
  MoreData(this.user);
  final User user;

  @override
  _MoreData createState() => _MoreData();
}

class _MoreData extends State<MoreData> {
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    var user = widget.user;
    if (!user.onBoardingDone && user.name == null) {
      return GiveName(user);
    }

    if (!user.onBoardingDone && user.babyBirthDate == null) {
      return GiveBirthDate(user);
    }

    return Scaffold(
      appBar: getAppBar(context),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(60),
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Congratulations on the new arrival!',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Image(image: AssetImage('undraw_baby_ja7a@2x.png'))
            ]),
      ),
    );
  }
}
