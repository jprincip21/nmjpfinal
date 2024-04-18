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
        title: Text(
          "Pokédex",
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
          var pokemons = snapshot.data as List<Pokemon>;
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, ind) {
              var pokemon = pokemons[ind];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/dataDetails',
                      arguments: {'id': pokemon.id, 'name': pokemon.name});
                },
                leading: CircleAvatar(
                  child: Text(pokemon.getImage()),
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
    var url = 'https://softwium.com/api/pokemons';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map<Pokemon>((m) => Pokemon.fromJson(m)).toList();
    } else {
      throw Exception('Failed to fetch Pokemon');
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

  Pokemon({
    required this.id,
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