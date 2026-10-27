abstract class ApiEntity {
  int get id;
  String get title;
  String? get subtitle;
  String? get imageUrl;
  String get description;

  /// Datos extra para mostrar en el detalle (etiqueta -> valor)
  Map<String, String> get details;

  /// Clave de ordenamiento del listado. Por defecto, el título.
  String get sortKey => title;

  Map<String, dynamic> toJson();
}