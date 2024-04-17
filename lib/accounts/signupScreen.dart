import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();
  final _passFieldController = TextEditingController();
  final _userFieldController = TextEditingController();

  bool isValidUser(String input){
    final userRegex = RegExp(r'^[A-Za-z][A-Za-z0-9_]{2,29}$').hasMatch(input);
    return input.isNotEmpty && userRegex;
  }

  bool isValidEmail(String input){
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input);
    return input.isNotEmpty && emailRegex;

  }

  bool isValidPass(String input){
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(input);
    return input.isNotEmpty && passRegex;
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text("Sign Up Screen", style: TextStyle(color: Colors.white),)
      ),
      body:
      Form(
        autovalidateMode: AutovalidateMode.always,
        //User Input
          key: _formKey,
          child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [

                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.people),
                      hintText: "Enter Username",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                  keyboardType: TextInputType.name,
                  controller: _userFieldController,
                  validator: (val) =>
                  isValidUser(val!) ? null : "Invalid Username",
                ),

                //Email Input
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.people),
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


                //Pass Input
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.people),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passFieldController,
                  validator: (val) =>
                  isValidPass(val!) ? null : "Passwords must be: \n- 8 Characters \n- 1 Uppercase \n- 1 Lowercase \n- 1 Number (0-9) \n- 1 Special Character (@\$!%*?&)",
                ),

                Container(
                    padding: const EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),

                    //Sign Up Button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            await Navigator.pushNamed(context, '/login');
                          }
                        },child: const Text("Sign Up", style: TextStyle(color: Colors.white))
                    )
                )
              ])
      )
    );
  }
}