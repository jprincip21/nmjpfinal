//Jonathan Principato 000851929
//Nick Mulas 000866712
//Final Project Mobile Embedded Devices CENG10021
//April 16 2024

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'accounts/loginScreen.dart';
import 'accounts/profilesScreen.dart';
import 'accounts/signupScreen.dart';
import 'data/dataDetails.dart';
import 'data/dataList.dart';
import 'data/dataVisual.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(initialRoute: '/signup',
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
