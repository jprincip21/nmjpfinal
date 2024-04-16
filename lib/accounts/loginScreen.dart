import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text("Login Screen", style: TextStyle(color: Colors.white),)
      ),
    );
  }
}