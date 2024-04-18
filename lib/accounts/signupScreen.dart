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
  final _passConfFieldController = TextEditingController();
  // final _userFieldController = TextEditingController();
  //
  // bool isValidUser(String input){
  //   final userRegex = RegExp(r'^[A-Za-z][A-Za-z0-9_]{2,29}$').hasMatch(input);
  //   return input.isNotEmpty && userRegex;
  // }

  bool isValidEmail(String input){
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input);
    return input.isNotEmpty && emailRegex;

  }

  bool isValidPass(String input){
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(input);
    return input.isNotEmpty && passRegex;
  }

  bool isValidPassConf(String input){
    if((_passConfFieldController.text == _passFieldController.text) && _passFieldController.text.isNotEmpty){
      return true;}
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red,
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

                  // TextFormField(
                  //   style: const TextStyle(color: Colors.white),
                  //   decoration: const InputDecoration(
                  //       icon: Icon(Icons.people, color: Colors.white),
                  //       hintText: "Enter Username",
                  //       hintStyle: TextStyle(color: Colors.grey),
                  //       labelText: "Username",
                  //       labelStyle: TextStyle(color: Colors.white)
                  //   ),
                  //   keyboardType: TextInputType.name,
                  //   controller: _userFieldController,
                  //   validator: (val) =>
                  //   isValidUser(val!) ? null : "Invalid Username",
                  // ),

                  //Email Input
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


                  //Pass Input
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password, color: Colors.white),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white)
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passFieldController,
                    validator: (val) =>
                    isValidPass(val!) ? null : "Passwords must be: \n\t- 8 Characters \n\t- 1 Uppercase \n\t- 1 Lowercase \n\t- 1 Number (0-9) \n\t- 1 Special Character (@\$!%*?&)",
                  ),

                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password, color: Colors.white),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.white)
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passConfFieldController,
                    validator: (val) =>
                    isValidPassConf(val!) ? null : "Passwords Must Match",
                  ),

                  Container(
                      padding: const EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),

                      //Sign Up Button
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, ),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: _emailFieldController.text,
                                  password: _passFieldController.text).then((value) {
                                Navigator.pushNamed(context, '/login');
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            }
                          },child: const Text("Sign Up", style: TextStyle(color: Colors.white))
                      )
                  )
                ])
        )
    );
  }
}