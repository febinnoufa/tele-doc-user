class CategoryModel {
  final String name;
  final String image;
  final String id;

  CategoryModel({required this.name, required this.image, required this.id});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        id: map['id'] ?? '');
  }
}
