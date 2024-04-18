//Data List
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
                      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.star_outline, color: Colors.yellow,)),
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
            label: 'Data List',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Data Visual',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profiles',
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

// Future<List<Sprites>> getSprite(int id) async {
//   var url = 'https://pokeapi.co/api/v2/pokemon/$id/';
//   var response = await http.get(Uri.parse(url));
//   //print('Response status: ${response.statusCode}');
//   //print('Response body: ${response.body}');
//   if (response.statusCode == 200) {
//     List jsonResponse = jsonDecode(response.body);
//     return jsonResponse.map<Sprites>((m) => Sprites.fromJson(m)).toList();
//   } else {
//     throw Exception('Failed to fetch Pokemon');
//   }
// }
//
// class Sprites {
//
//   final String sprite;
//
//
//   Sprites({
//     required this.sprite,
//   });
//
//   factory Sprites.fromJson(Map<String, dynamic> json) {
//     return Sprites(
//       sprite: json['sprites']['front_default'],
//     );
//   }
// }