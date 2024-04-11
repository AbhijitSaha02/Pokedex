import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pokedex_app/screens/home.dart';
import 'package:pokedex_app/screens/signup_screen.dart';
import 'package:pokedex_app/net/flutterfire.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int activeIndex = 0;
  late Validator shouldNavigate = Validator(value: false, code: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 3) activeIndex = 0;
      });
    });

    super.initState();
  }

  void checkValues() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      shouldNavigate =
          await logIn(emailController.text, passwordController.text);
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
              'https://i.pinimg.com/736x/0e/00/34/0e0034db3e6608d7875a585713a98dde--pokemon-phone-wallpaper-anime-iphone-wallpaper.jpg'),
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 75,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Welcome again Trainer!!\nPlease Login to use your Pokedex.',
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
                        height: screenHeight * 0.45,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Stack(
                          children: [
                            AnimatedOpacity(
                              opacity: activeIndex == 0 ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceInOut,
                              child: Image.network(
                                'https://www.nicepng.com/png/full/132-1322474_mega-charizard-x-png.png',
                                height: screenHeight * 0.5,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: activeIndex == 1 ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceInOut,
                              child: Image.network(
                                'https://pre00.deviantart.net/0af6/th/pre/i/2015/267/8/f/sceptile_for_smash_bros__transparent_by_yfighter2-d9ar0ek.png',
                                height: screenHeight * 0.5,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: activeIndex == 2 ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceInOut,
                              child: Image.network(
                                'https://66.media.tumblr.com/11e8c52df7af010ac5d4f025f5794950/tumblr_poorsp9cCt1ugozp8o1_1280.png',
                                height: screenHeight * 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
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
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password.';
                          } else if (!shouldNavigate.value) {
                            return shouldNavigate.code;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'Password',
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_person_rounded,
                            color: Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
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
                        focusColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const SignUpScreen())));
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
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
