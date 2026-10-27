import 'api_entity.dart';

class Department implements ApiEntity {
  @override
  final int id;
  final String name;
  @override
  final String description;
  final int? population;
  final double? surface;
  final String? phonePrefix;
  final int? municipalities;
  final String? capitalName;

  Department({
    required this.id,
    required this.name,
    required this.description,
    this.population,
    this.surface,
    this.phonePrefix,
    this.municipalities,
    this.capitalName,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Sin nombre',
        description:
            (json['description'] ?? 'Sin descripción').toString().trim(),
        population: (json['population'] as num?)?.toInt(),
        surface: (json['surface'] as num?)?.toDouble(),
        phonePrefix: json['phonePrefix']?.toString(),
        municipalities: (json['municipalities'] as num?)?.toInt(),
        capitalName: (json['cityCapital'] as Map<String, dynamic>?)?['name'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'population': population,
        'surface': surface,
        'phonePrefix': phonePrefix,
        'municipalities': municipalities,
        'cityCapital': capitalName == null ? null : {'name': capitalName},
      };

  @override
  String get title => name;

  @override
  String get sortKey => title;

  @override
  String? get subtitle => capitalName != null ? 'Capital: $capitalName' : null;

  @override
  String? get imageUrl => null;

  @override
  Map<String, String> get details => {
        if (capitalName != null) 'Capital': capitalName!,
        if (population != null) 'Población': '$population',
        if (surface != null) 'Superficie (km²)': surface!.toStringAsFixed(0),
        if (municipalities != null) 'Municipios': '$municipalities',
        if (phonePrefix != null) 'Prefijo telefónico': phonePrefix!,
      };
}