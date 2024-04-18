//Profiles
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profiles extends StatefulWidget {
  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
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
          "Profile Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Change Username"),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Change Email"),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Change Password"),
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushNamed(context, '/login');
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
