import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nmjpfinal/data/dataList.dart';

class DataDetails extends StatefulWidget {

  @override
  State<DataDetails> createState() => _DataDetailsState();
}

class _DataDetailsState extends State<DataDetails> {
  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    var id = args['id'] as int;
    var name = args['name'] as String;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: FutureBuilder<PokemonDetails>(
          future: getPokemonDetails(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var details = snapshot.data!;
              return Column(
                children: [
                  Row(
                    children: [
                      Text("Pokédex ID #: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text(details.id.toString(), style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Type(s): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text(details.types[0], style: TextStyle(color: Colors.white),)
                      

                    ],
                  ),
                  Row(
                    children: [
                      Text("Height: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text("${details.height.toString()}m", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Weight: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text("${details.weight.toString()}Kgs", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              );

            } else if (snapshot.hasError) {
              return const Text('Error Fetching Pokemon Details', style: TextStyle(color: Colors.white),);
            }
            return const CircularProgressIndicator();
            },
      ),

    );
  }
}

Future<PokemonDetails> getPokemonDetails(int id) async {
  var url = 'https://softwium.com/api/pokemons/$id';
  var response = await http.get(Uri.parse(url));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return PokemonDetails.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to fetch Data');
  }
}

class PokemonDetails {
  final int id;
  final String name;
  final double height;
  final double weight;
  final List<String> types;


  PokemonDetails({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      height: json['height'] is int ? json['height'].toDouble() : json['height'],
      weight: json['weight'] is int ? json['weight'].toDouble() : json['weight'],
      types: List<String>.from(json['types']),
    );
  }
}

String getTyping(List<String> types){
  if(types[1].isNotEmpty) {
    return types[0];
      //"${types[0]}, ${types[1]} ";
  }
  else {
    return types[0];
  }
}