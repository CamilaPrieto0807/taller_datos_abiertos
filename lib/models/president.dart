import 'api_entity.dart';

class President implements ApiEntity {
  @override
  final int id;
  final String name;
  final String lastName;
  final String? startPeriodDate;
  final String? endPeriodDate;
  final String? politicalParty;
  @override
  final String description;
  final String? image;

  President({
    required this.id,
    required this.name,
    required this.lastName,
    this.startPeriodDate,
    this.endPeriodDate,
    this.politicalParty,
    required this.description,
    this.image,
  });

  factory President.fromJson(Map<String, dynamic> json) => President(
        id: json['id'] ?? 0,
        name: (json['name'] ?? '').toString().trim(),
        lastName: (json['lastName'] ?? '').toString().trim(),
        startPeriodDate: json['startPeriodDate']?.toString(),
        endPeriodDate: json['endPeriodDate']?.toString(),
        politicalParty: json['politicalParty'],
        description:
            (json['description'] ?? 'Sin descripción').toString().trim(),
        image: json['image'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'startPeriodDate': startPeriodDate,
        'endPeriodDate': endPeriodDate,
        'politicalParty': politicalParty,
        'description': description,
        'image': image,
      };

  String _year(String? d) =>
      (d != null && d.length >= 4) ? d.substring(0, 4) : '?';

  String _date(String? d) =>
      (d != null && d.length >= 10) ? d.substring(0, 10) : '?';

  @override
  String get title => '$name $lastName'.trim();

  @override
  String? get subtitle => '${_year(startPeriodDate)} - ${_year(endPeriodDate)}';

  @override
  String? get imageUrl =>
      (image == null || image!.isEmpty) ? null : image;

  /// Se usa para ordenar cronológicamente.
  @override
  String get sortKey => startPeriodDate ?? '';

  @override
  Map<String, String> get details => {
        if (politicalParty != null) 'Partido': politicalParty!,
        'Inicio del período': _date(startPeriodDate),
        'Fin del período': _date(endPeriodDate),
      };
}