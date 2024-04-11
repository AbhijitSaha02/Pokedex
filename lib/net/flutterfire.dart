import 'package:firebase_auth/firebase_auth.dart';

class Validator {
  bool value;
  String code;

  Validator({
    required this.value,
    required this.code,
  });
}

Future<Validator> logIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return Validator(value: true, code: '');
  } catch (e) {
    print(e.toString());
    return Validator(value: false, code: e.toString());
  }
}

Future<Validator> signUp(String userName, String email, String password) async {
  String code = '';
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return Validator(value: true, code: '');
  } on FirebaseException catch (e) {
    if (e.code == 'weak-password') {
      print('The password is too weak.');
      code = 'The password is too weak';
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists with that email.');
      code = 'The account already exists with that email';
    }
    return Validator(value: false, code: code);
  } catch (e) {
    print(e.toString());
    return Validator(value: false, code: e.toString());
  }
}
