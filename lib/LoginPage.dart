import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes_app/HomePage.dart';
import 'package:tubes_app/RegisterPage.dart';
import 'package:tubes_app/main.dart';
import 'package:http/http.dart' as http; // error nya dari sini
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> loginUser(String email, String password, BuildContext context) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Uri url = Uri.parse('http://192.168.0.110:8000/api/login');
    final Map<String, String> body = {'email': email, 'password': password};

    print("email: $email\tpassword: $password");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Store the token object as a JSON string in SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = jsonEncode(responseBody['token']);
      sharedPreferences.setString('token', token);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      // Handle error response
      final snackBar = SnackBar(
        content: Text('Login gagal. cek lagi email dan passwordnya!!!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.9,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                margin: const EdgeInsets.only(top: 50, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 50), // for vertical spacing
                    const CircleAvatar(
                      // avatar in upper part of login page
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person_rounded,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const Align(
                      // align the text into Center
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cardo',
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // vertical spacing
                    TextFormField(
                      // form input for email
                      controller: emailController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Input your Email here...',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                              // set the underline border into black
                              borderSide: BorderSide(color: Colors.black))),
                      onSaved: (String? value) {
                        // Nanti buat ambil value yang diinput
                      },
                      validator: (String? value) {
                        // buat validasi input
                      },
                    ),
                    const SizedBox(height: 10), // for vertical spacing
                    TextFormField(
                      // inpnut password
                      controller: passwordController,
                      // hide the inputted value
                      obscureText: true,
                      // form setting
                      decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Input your password here...",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      onSaved: (String? value) {
                        // nanti buat ambil data input
                      },
                      validator: (String? value) {
                        // nanti buat validasi input
                      },
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 50, right: 50, left: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle login button press
                          // dipindahin ke home screen
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

                          String email = emailController.text;
                          String password = passwordController.text;

                          loginUser(email, password, context);
                        },
                        // button untuk login
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Cardo',
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // vertical spacing
                    // register text clickable
                    Align(
                      // separate the first clause to become not clickable
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Haven't got any account yet? ",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            // make the second clause clickable
                            TextSpan(
                              text: "Register Here!",
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    // temporary move to home screen
                                    // it should be move to register
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
