class Drinks {
  late String name;

  Drinks({required this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
