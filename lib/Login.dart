import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // pindah ke register kalo tap register
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // pindah ke home kalo tap login
                Navigator.pushNamed(context, '/home'); 
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
