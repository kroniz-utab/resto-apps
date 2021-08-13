class Foods {
  late String name;

  Foods({
    required this.name,
  });

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
