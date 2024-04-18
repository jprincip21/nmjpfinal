//Profiles
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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

            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          backgroundColor: Colors.grey.shade800,
                          title: Text("Confirm Credientials Before Changing Email", style: TextStyle(color: Colors.white),),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.email, color: Colors.white,),
                                      hintText: "New Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      labelText: "New Email",
                                      labelStyle: TextStyle(color: Colors.white)
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailChangeFieldController,
                                  validator: (val) =>
                                  isValidEmail(val!) ? null : "Invalid Email",
                                ),

                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.email, color: Colors.white,),
                                      hintText: "Current Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      labelText: "Current Email",
                                      labelStyle: TextStyle(color: Colors.white)
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailFieldController,
                                  validator: (val) =>
                                  isValidEmail(val!) ? null : "Invalid Email",
                                ),

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

                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("Cancel")),
                            ElevatedButton(onPressed: (){
                              if(_formKey.currentState!.validate()) {
                                FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(EmailAuthProvider
                                    .credential(email: _emailFieldController.text, password: _passFieldController.text)).then((value) {
                                  FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(
                                      _emailChangeFieldController.text);
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString()}");
                                });
                              }
                              }, child: Text("Confirm")),

                          ],
                        ));


              },
              child: Text("Change Email"),
            ),

            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email.toString());
              },
              child: Text("Update Password"),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Data List',
      //     ),
      //
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart),
      //       label: 'Data Visual',
      //     ),
      //
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profiles',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey.shade800,
      //   onTap: _onItemTapped,
      // ),
    );
  }
  // void _onItemTapped(int index) {
  //   if (index == 0) {
  //     Navigator.pushNamed(context, '/dataList');
  //   }  else if (index == 1) {
  //     Navigator.pushNamed(context, '/dataVisual');
  //   } else if (index == 2) {
  //   }
  // }
}


