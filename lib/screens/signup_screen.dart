import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pokedex_app/net/flutterfire.dart';
import 'package:pokedex_app/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  late Validator shouldNavigate = Validator(value: false, code: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void checkValues() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      shouldNavigate = await signUp(
          nameController.text, emailController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
      width: screenwidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/originals/33/d4/76/33d476e14b4178ebd6233a5ceab07ea3.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          height: 75,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Welcome New Trainer!!\nPlease Register to become a part of PokeFamily.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 7,
                                    color: Colors.black,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        width: screenwidth,
                        child: const Image(
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/47/55/4e/47554e71f2708844dfd36c8345175e91.png'),
                          alignment: Alignment.center,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {},
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'Name',
                          hintText: 'Name',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(251, 182, 1, 1),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromRGBO(251, 182, 1, 1),
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(251, 182, 1, 1),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your e-mail.';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid E-mail Id.';
                          } else if (!shouldNavigate.value &&
                              !shouldNavigate.code
                                  .toLowerCase()
                                  .contains('password')) {
                            return shouldNavigate.code;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'E-mail',
                          hintText: 'E-mail',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(251, 182, 1, 1),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Color.fromRGBO(251, 182, 1, 1),
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(251, 182, 1, 1),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the new password.';
                          } else if (!shouldNavigate.value &&
                              !shouldNavigate.code
                                  .toLowerCase()
                                  .contains('email')) {
                            return shouldNavigate.code;
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'Password',
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(251, 182, 1, 1),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_person_rounded,
                            color: Color.fromRGBO(251, 182, 1, 1),
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(251, 182, 1, 1),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.yellow),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      MaterialButton(
                        onPressed: () {
                          checkValues();
                          if (shouldNavigate.value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        height: 45,
                        elevation: 10,
                        color: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
