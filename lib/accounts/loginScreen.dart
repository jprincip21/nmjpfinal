import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  bool isValidEmail(String input){
    final emailRegex = RegExp(r'^(([^<>()[]\.,;:\s@"]+(.[^<>()[]\.,;:\s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$').hasMatch(input);
    return input.isNotEmpty && emailRegex;

  }

  void _login() {
    String email = _emailFieldController.text;
    String password = _passwordFieldController.text;
    if (!isValidEmail(email)) {
      print('Invalid email address');
      return;
    }
    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(
          "Login Screen",
          style: TextStyle(color: Colors.white),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white,),
              hintText: "Enter Email",
              hintStyle: TextStyle(color: Colors.grey),
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.white)
          ),
          keyboardType: TextInputType.emailAddress,
          controller: _emailFieldController,
          validator: (val) =>
          isValidEmail(val!) ? null : "Invalid Email",
                ),

              SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  icon: Icon(Icons.password, color: Colors.white,),
                  hintText: "Enter Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white)
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordFieldController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),

            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?", style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                    },
                  child: Text('Sign up Here!', style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      )
    );
  }
}
