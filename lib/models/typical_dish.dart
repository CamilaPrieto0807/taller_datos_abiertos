import 'api_entity.dart';

class TypicalDish implements ApiEntity {
  @override
  final int id;
  final String name;
  @override
  final String description;
  final String? ingredients;
  final String? image;
  final int? departmentId;
  final String? departmentName;

  TypicalDish({
    required this.id,
    required this.name,
    required this.description,
    this.ingredients,
    this.image,
    this.departmentId,
    this.departmentName,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) => TypicalDish(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Sin nombre',
        description: (json['description'] ?? 'Sin descripción').toString().trim(),
        ingredients: json['ingredients'],
        image: json['imageUrl'],
        departmentId: json['departmentId'],
        departmentName: (json['department'] as Map<String, dynamic>?)?['name'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'ingredients': ingredients,
        'imageUrl': image,
        'departmentId': departmentId,
        'department': departmentName == null ? null : {'name': departmentName},
      };

  @override
  String get title => name;

  @override
  String get sortKey => title;

  @override
  String? get subtitle => departmentName ?? ingredients;

  // La API devuelve URLs con espacios; hay que codificarlas.
  @override
  String? get imageUrl =>
      (image == null || image!.isEmpty) ? null : Uri.encodeFull(image!);

  @override
  Map<String, String> get details => {
        if (departmentName != null) 'Departamento': departmentName!,
        if (ingredients != null) 'Ingredientes': ingredients!,
      };
}