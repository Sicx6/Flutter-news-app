import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/components/custom_snackbar.dart';
import 'package:flutter_news_/screens/login_screen.dart';
import 'package:flutter_news_/components/custom_button.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/signUp-screen';
  @override
  Widget build(BuildContext context) {
    void navigateLoginScreen() {
      Navigator.pushNamed(context, LoginScreen.routeName);
    }

    final _signUpKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/signup.png',
              height: 200,
            ),
            const SizedBox(height: 20.0),
            Form(
                key: _signUpKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Password',
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Sign Up?'),
                TextButton(
                    onPressed: () => navigateLoginScreen(),
                    child: const Text('Login')),
              ],
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              textButton: 'Sign Up',
              onTap: () {
                AppUser().signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text);

                CustomSnackBar(context, 'Registered Success');
              },
              backgroundTextColor: Colors.deepPurple,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
