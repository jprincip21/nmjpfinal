//Jonathan Principato 000851929
//Nick Mulas 000866712
//Final Project

import 'package:flutter/material.dart';

import 'accounts/loginScreen.dart';
import 'accounts/profilesScreen.dart';
import 'accounts/signupScreen.dart';
import 'data/dataDetails.dart';
import 'data/dataList.dart';
import 'data/dataVisual.dart';

void main() {
  runApp(
      MaterialApp(initialRoute: '/login',
        routes: {
          '/login':(context) => Login(),
          '/signup': (context) => SignUp(),
          '/profiles':(context) => Profiles(),
          '/dataList': (context) => DataList(),
          '/dataDetails': (context) => DataDetails(),
          '/dataVisual': (context) => DataVisual(),

        },)
  );
}

