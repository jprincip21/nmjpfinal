//profile screen
import 'package:flutter/material.dart';

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
      title: Text("Profile Screen", style: TextStyle(color: Colors.white),),
    ),);
  }
}