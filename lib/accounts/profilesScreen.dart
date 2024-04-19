//Profiles
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profiles extends StatefulWidget {
  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {

  TextEditingController _emailChangeFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passFieldController = TextEditingController();
  // TextEditingController _userFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool isValidEmail(String input){
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input);
    return input.isNotEmpty && emailRegex;

  }
  bool isValidPass(String input){
    return input.isNotEmpty;
  }

  // bool isValidUser(String input){
  //   final userRegex = RegExp(r'^[A-Za-z][A-Za-z0-9_]{2,29}$').hasMatch(input);
  //   return input.isNotEmpty && userRegex;
  // }

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),

            // TextFormField(
            //   style: const TextStyle(color: Colors.white),
            //   decoration: const InputDecoration(
            //       icon: Icon(Icons.people, color: Colors.white),
            //       hintText: "Enter New Username",
            //       hintStyle: TextStyle(color: Colors.grey),
            //       labelText: "Username",
            //       labelStyle: TextStyle(color: Colors.white)
            //   ),
            //   keyboardType: TextInputType.name,
            //   controller: _userFieldController,
            //   validator: (val) =>
            //   isValidUser(val!) ? null : "Invalid Username",
            // ),
            //
            // ElevatedButton(
            //   onPressed: () {
            //     FirebaseAuth.instance.currentUser?.updateDisplayName(_userFieldController.text);
            //
            //   },
            //   child: Text("Change Username"),
            // ),
            Text("Account Details:",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),



            Text(
              "Email: ${FirebaseAuth.instance.currentUser?.email}"
                  "\nUser ID: ${FirebaseAuth.instance.currentUser?.uid.toString()}\n ",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,),

            Image.asset(
              'images/Red.png',
              height: 325,
            ),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, ),
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email.toString());
              },
              child: Text("Reset Password", style: TextStyle(color: Colors.white)),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, ),
              onPressed: () async {
                await cloudUser(false).then((value) async {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                });

              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),

    );
  }

  Future<void> cloudUser(bool status) async {
    final CollectionReference onlineUser = FirebaseFirestore.instance.collection('onlineStatus');
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
    onlineUser.doc(uid).set({'online' : status}, SetOptions(merge: true));
    return;
  }
}


