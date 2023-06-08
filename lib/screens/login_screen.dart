import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/components/custom_button.dart';
import 'package:flutter_news_/components/custom_snackbar.dart';
import 'package:flutter_news_/screens/home.dart';
import 'package:flutter_news_/screens/homepage.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateHomepageScreen() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  final _loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              height: 200,
            ),
            const SizedBox(height: 20.0),
            Form(
                key: _loginKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightGrey,
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.lightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not register?'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Register'))
              ],
            ),
            const SizedBox(height: 16.0),
            CustomButton(
                textButton: 'Log In',
                onTap: () async {
                  if (_loginKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    await AppUser().signIn(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                backgroundTextColor: Colors.deepPurple,
                textColor: Colors.white),
            const SizedBox(height: 16.0),
            CustomButton(
                textButton: 'Guest Login',
                onTap: () async {
                  await AppUser().signInAnonymously(context);
                },
                backgroundTextColor: Color.fromARGB(255, 252, 249, 251),
                textColor: Colors.deepPurple)
          ],
        ),
      ),
    );
  }
}
