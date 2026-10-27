import 'package:flutter_test/flutter_test.dart';
import 'package:taller_datos_abiertos/models/touristic_attraction.dart';

void main() {
  test('reads department id from the attraction city', () {
    final attraction = TouristicAttraction.fromJson({
      'id': 12,
      'name': 'Parque',
      'description': 'Atractivo turístico',
      'images': ['https://example.com/parque.jpg'],
      'city': {'name': 'Medellín', 'departmentId': 2},
    });

    expect(attraction.departmentId, 2);
    expect(attraction.imageUrl, 'https://example.com/parque.jpg');
  });
}
