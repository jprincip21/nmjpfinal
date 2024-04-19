//Data List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataList extends StatefulWidget {

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 10,
        shadowColor: Colors.black,
        leading: Text(""),
        title: Text(
          "Pokédex",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: getPokemon(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var pokemons = snapshot.data as List<Pokemon>;
              return ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context, ind) {
                    var pokemon = pokemons[ind];
                    return ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, '/dataDetails',
                            arguments: {'id': pokemon.id, 'name': pokemon.name});
                      },
                      leading: CircleAvatar(
                        child: Text(pokemon.getImage()),
                      ),
                      title: Text(pokemon.name, style: TextStyle(color: Colors.white),),
                      trailing: IconButton(onPressed: () {(
                          favouriteData(pokemon.id));
                        },
                          icon:Icon(Icons.star, color: Colors.yellow,)),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Text('Error');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pokemon',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Charts',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade800,
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index) {
    if (index == 0) {

    }  else if (index == 1) {
      Navigator.pushNamed(context, '/dataVisual');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profiles');
    }
  }
}

Future<List<Pokemon>> getPokemon() async {
  var url = 'https://softwium.com/api/pokemons';
  var response = await http.get(Uri.parse(url));
  //print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map<Pokemon>((m) => Pokemon.fromJson(m)).toList();
  } else {
    throw Exception('Failed to fetch Pokemon');
  }
}

class Pokemon {
  final int id;
  final String name;


  Pokemon({required this.id,
    required this.name,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
    );
  }
  String getImage() => name.split(" ").map((word) => word[0]).join();

}

Future<bool> favouriteData(int id) async {

  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
  final onlineUser = FirebaseFirestore.instance.collection('onlineStatus').doc(uid);
  late bool favourite;

  var snapshot = await onlineUser.get();
  if(snapshot.exists){
    Map<String, dynamic> data = snapshot.data()!;
    onlineUser.set({"favourites": {'$id' : false}}, SetOptions(merge: true));
    var favourites = data['favourites']['$id'];
    //print(data);


    if(favourites == false || favourites == null){
      favourite = true;
    }
    else{
      favourite = false;
    }
    //print(favourite);
  }

  onlineUser.set({"favourites": {'$id' : favourite}}, SetOptions(merge: true));

  return favourite;
}





