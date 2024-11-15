class ItemModel {
  int? id;
  String? name;
  dynamic price;
  String? description;
  String? category;
  String? image;
  ItemModel({
    required this.name,
    required this.image,
    required this.price,
    required this.id,
    required this.description,
    required this.category,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json["title"],
      image: json["image"],
      price: json["price"],
      id: json["id"],
      description: json["description"],
      category: json["category"],
    );
  }
}
