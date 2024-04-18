import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class DataVisual extends StatefulWidget {
  @override
  State<DataVisual> createState() => _DataVisualState();
}

class _DataVisualState extends State<DataVisual> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(

        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 10,
          shadowColor: Colors.black,
          title: Text(
            "Charts",
            style: TextStyle(color: Colors.white),
          ),

          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.bar_chart),
                text: 'Name vs. Weight',
              ),
              Tab(
                icon: Icon(Icons.show_chart),
                text: 'ID vs. Height',
              ),
            ],
          ),
        ),

        body:
        FutureBuilder<List<Pokemon>>(
            future: getPokemon(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var pokemons = snapshot.data as List<Pokemon>;

                var seriesList1 = [
                  charts.Series<Pokemon, String>(
                    id: 'Name vs Weight',
                    domainFn: (Pokemon pokemon, _) => pokemon.name,
                    measureFn: (Pokemon pokemon,_) => pokemon.weight,
                    colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                    labelAccessorFn: (Pokemon pokemon, _) => pokemon.weight.toString(),
                    data: pokemons,
                  )
                ];

                var seriesList2 = [
                  charts.Series<Pokemon, int>(
                    id: 'ID vs. Weight',
                    data: pokemons,
                    domainFn: (Pokemon pokemon, _) => pokemon.id,
                    measureFn: (Pokemon pokemon, _) => pokemon.height,
                    colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                  )
                ];
                return TabBarView(
                    children: <Widget>[
                      Container(child: Center(child: charts.BarChart(
                        seriesList1,
                        animate: true,
                        domainAxis: const charts.OrdinalAxisSpec(
                            renderSpec: charts.SmallTickRendererSpec(
                                labelRotation: 60,
                                labelStyle: charts.TextStyleSpec(
                                    fontSize: 14, // size in Pts.
                                    color: charts.MaterialPalette.white),

                                lineStyle:charts.LineStyleSpec(
                                    color: charts.MaterialPalette.white)

                            )),
                        primaryMeasureAxis: const charts.NumericAxisSpec(
                            renderSpec:charts.GridlineRendererSpec(


                                labelStyle:charts.TextStyleSpec(
                                    fontSize: 14, // size in Pts.
                                    color: charts.MaterialPalette.white),

                                lineStyle:charts.LineStyleSpec(
                                    color: charts.MaterialPalette.white))),

                        barRendererDecorator: charts.BarLabelDecorator<String>(
                          insideLabelStyleSpec: const charts.TextStyleSpec(color: charts.Color.white, fontSize: 5),
                          outsideLabelStyleSpec: const charts.TextStyleSpec(color: charts.Color.white, fontSize: 5),
                        ),

                      ),)),
                       Container(child: Center(child: charts.LineChart(
                         seriesList2,
                         animate: true,
                         defaultRenderer: charts.LineRendererConfig(includePoints: true),
                       ))),

                     ],
                    );
              } else if (snapshot.hasError) {
                return const Text('Error');
              }

              return const CircularProgressIndicator();
            },
          ),

         //

        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.black,
        //   items: const <BottomNavigationBarItem>[
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
        //
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.grey.shade800,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (index == 0) {
  //     Navigator.pushNamed(context, '/dataList');
  //   } else if (index == 2) {
  //     Navigator.pushNamed(context, '/profiles');
  //   }
  // }
}

Future<List<Pokemon>> getPokemon() async {
  var url = 'https://softwium.com/api/pokemons?limit=25';
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
  final double height;
  final double weight;
  final List<String> types;


  Pokemon({required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'] is int ? json['height'].toDouble() : json['height'],
      weight: json['weight'] is int ? json['weight'].toDouble() : json['weight'],
      types: List<String>.from(json['types']),
    );
  }
}