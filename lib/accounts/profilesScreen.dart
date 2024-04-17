import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Profiles extends StatefulWidget {

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text("Profile Screen", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(onPressed: () async {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamed(context, '/login');
            }).onError((error, stackTrace) {
              print("Error ${error.toString()}");
            });
          }, icon: Icon(Icons.logout, color: Colors.white, ))

        ],

      ),
    body:

        Column(

          children: [
          Row(children: [
            Text("Username: ", style: TextStyle(color: Colors.white, fontSize: 24),),
            Text(FirebaseAuth.instance.currentUser!.displayName.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
          ],),
            Row(children: [
              Text("Email: ", style: TextStyle(color: Colors.white, fontSize: 24)),
              Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
            ],)



          ],
        ),
      );
  }
}