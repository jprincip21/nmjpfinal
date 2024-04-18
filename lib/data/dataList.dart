import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    initialRoute: '/dataList',
    routes: {
      '/dataList': (context) => DataList(),
      '/dataDetails': (context) => DataDetailsScreen(),
      // Add other routes as needed
    },
  ));
}

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
        title: Text(
          "Pokémon",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Data List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information_outlined),
            label: 'Data Details',
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
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Pokemon>>(
      future: getPokemon(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var pokemons = snapshot.data!;
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, ind) {
              var pokemon = pokemons[ind];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/dataDetails',
                    arguments: pokemon,
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(pokemon.spriteUrl),
                ),
                title: Text(
                  pokemon.name,
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Pokemon>> getPokemon() async {
    var url1 = 'https://pokeapi.co/api/v2/pokemon?limit=20';
    var url2 = 'https://softwium.com/api/pokemons';
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      List<Pokemon> pokemons = [];
      Map<String, dynamic> data1 = jsonDecode(response1.body);
      List<dynamic> results1 = data1['results'];
      for (var result in results1) {
        String name = result['name'];
        String url = result['url'];
        pokemons.add(await fetchPokemonDetails(name, url));
      }

      List<dynamic> jsonResponse = jsonDecode(response2.body);
      for (var jsonPokemon in jsonResponse) {
        pokemons.add(Pokemon.fromJson(jsonPokemon));
      }

      return pokemons;
    } else {
      throw Exception('Failed to fetch Pokemon');
    }
  }

  Future<Pokemon> fetchPokemonDetails(String name, String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String spriteUrl = data['sprites']['front_default'];
      return Pokemon(id: data['id'], name: name, spriteUrl: spriteUrl);
    } else {
      throw Exception('Failed to fetch Pokemon details');
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/dataList');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/dataDetails');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/dataVisual');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profiles');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}

class Pokemon {
  final int id;
  final String name;
  final String spriteUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.spriteUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      spriteUrl: '',
    );
  }
}

class DataDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: ${pokemon.name}'),
            Text('ID: ${pokemon.id}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}