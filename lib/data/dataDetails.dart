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

      body: Center(
        child: FutureBuilder<List<PokemonDetails>>(
          future: getPokemonDetails(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var details = snapshot.data as List<PokemonDetails>;
              return ListView.builder(
                  itemCount: details.length,
                  itemBuilder: (context, ind) {
                    var detail = details[ind];
                    return ListTile(
                      title: Text(detail.name),
                      //subtitle: Text(detail.height),
                      //trailing: Text(detail.count().toString()),
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

Future<List<PokemonDetails>> getPokemonDetails(int id) async {
  var url = 'https://softwium.com/api/pokemons/$id';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map<PokemonDetails>((m) => PokemonDetails.fromJson(m)).toList();
  } else {
    throw Exception('Failed to fetch Data');
  }
}

class PokemonDetails {
  final int id;
  final String name;
  final int height;
  final int weight;
  //final String types;


  PokemonDetails({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    //required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      //types: json['types'],
    );
  }
}