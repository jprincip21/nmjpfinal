class Pokemon {
  final int id;
  final String name;
  final int weight;
  final int height;
  //final String types;


  Pokemon({required this.id,
    required this.name,
    required this.weight,
    required this.height,
    //required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      height: json['height'],
      //types: json['types'],
    );
  }

}