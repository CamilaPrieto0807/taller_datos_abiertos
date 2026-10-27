import 'api_entity.dart';

class TouristicAttraction implements ApiEntity {
  @override
  final int id;
  final String name;
  @override
  final String description;
  final List<String> images;
  final double? latitude;
  final double? longitude;
  final String? cityName;

  TouristicAttraction({
    required this.id,
    required this.name,
    required this.description,
    this.images = const [],
    this.latitude,
    this.longitude,
    this.cityName,
  });

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    final rawName = (json['name'] ?? 'Sin nombre').toString().trim();
    return TouristicAttraction(
      id: json['id'] ?? 0,
      name: rawName.isEmpty
          ? 'Sin nombre'
          : rawName[0].toUpperCase() + rawName.substring(1),
      description:
          (json['description'] ?? 'Sin descripción').toString().trim(),
      images: (json['images'] as List?)
              ?.map((e) => e.toString().trim())
              .where((u) => u.startsWith('http'))
              .map((u) => u.replaceAll(' ', '%20'))
              .toList() ??
          [],
      latitude: double.tryParse('${json['latitude']}'),
      longitude: double.tryParse('${json['longitude']}'),
      cityName: (json['city'] as Map<String, dynamic>?)?['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'images': images,
        'latitude': latitude,
        'longitude': longitude,
        'city': cityName == null ? null : {'name': cityName},
      };

  @override
  String get title => name;

  @override
  String get sortKey => title;

  @override
  String? get subtitle => cityName ?? description;

  @override
  String? get imageUrl => images.isNotEmpty ? images.first : null;

  @override
  Map<String, String> get details => {
        if (cityName != null) 'Ciudad': cityName!,
        if (latitude != null) 'Latitud': '$latitude',
        if (longitude != null) 'Longitud': '$longitude',
      };
}