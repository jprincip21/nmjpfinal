import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataList extends StatefulWidget {

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(
          "Pokemon",
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
                    );
                  });
            } else if (snapshot.hasError) {
              return const Text('Error');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


Future<List<Pokemon>> getPokemon() async {
  var url = 'https://softwium.com/api/pokemons';
  var response = await http.get(Uri.parse(url));
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


