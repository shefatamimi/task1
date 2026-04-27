class CardModels {
  int? id;
  String name;
  String title;
  String description;

  CardModels({
    this.id,
    required this.name,
    required this.title,
    required this.description,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,

    };
  }

  // fromMap
  factory CardModels.fromMap(Map<String, dynamic> map) {
    return CardModels(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      description: map['description'],
    );
  }
}