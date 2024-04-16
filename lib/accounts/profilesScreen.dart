import 'package:flutter/material.dart';

class Profiles extends StatefulWidget {

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.red,
      title: Text("Profile Screen"),
    ),);
  }
}