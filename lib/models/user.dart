import 'dart:convert' show jsonDecode, base64, ascii;

class User {
  late String? name;
  late DateTime? babyBirthDate;
  late bool onBoardingDone = false;

  User.fromJson(Map<String, dynamic> userMap) {
    this.name =
        (userMap['user']['name'] != null ? userMap['user']['name'] : null);
    this.babyBirthDate = (userMap['user']['baby_birth_date'] != null
        ? DateTime.parse(userMap['user']['baby_birth_date'])
        : null);
    this.onBoardingDone = (userMap['user']['onboarding_done'] != null
        ? userMap['user']['onboarding_done']
        : false);
  }

  Map<String, dynamic> toJson() => {
        'name': (name != null ? name : null),
        'babyBirthDate': (babyBirthDate != null ? babyBirthDate : null),
        'onBoardingDone': onBoardingDone,
      };

  static User fromJWT(String jwt) {
    var payload = jsonDecode(
        ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
    User user = User.fromJson(payload);

    return user;
  }
}
