class Pokemon {
  int height, weight, order, baseExperience;
  String name, photoUrl;

  Pokemon.fromJson(Map<String, dynamic> json)
      : baseExperience = json['base_experience'],
        height = json['height'],
        order = json['order'],
        name = json['name'],
        weight = json['weight'],
        photoUrl =
            "https://img.pokemondb.net/artwork/large/" + json['name'] + ".jpg";
}
