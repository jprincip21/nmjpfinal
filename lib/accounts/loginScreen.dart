import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool isValidEmail(String input){
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input);
    return input.isNotEmpty && emailRegex;

  }
  bool isValidPass(String input){
    return input.isNotEmpty;
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
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
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
              controller: _passFieldController,
              validator: (val) =>
              isValidPass(val!) ? null : "Invalid Password",
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailFieldController.text,
                      password: _passFieldController.text).then((value) {
                    Navigator.pushNamed(context, '/profiles');
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }
              },
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
