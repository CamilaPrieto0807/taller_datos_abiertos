import 'package:flutter/material.dart';

import '../models/api_entity.dart';
import '../models/department.dart';
import '../models/president.dart';
import '../models/touristic_attraction.dart';
import '../models/typical_dish.dart';

class EndpointConfig {
  final String key;
  final String title;
  final String description;
  final String path;
  final IconData icon;
  final Color color;
  final ApiEntity Function(Map<String, dynamic>) fromJson;
  final bool sortByTitle;

  const EndpointConfig({
    required this.key,
    required this.title,
    required this.description,
    required this.path,
    required this.icon,
    required this.color,
    required this.fromJson,
    this.sortByTitle = false,
  });
}

final List<EndpointConfig> endpoints = [
  EndpointConfig(
    key: 'departments',
    title: 'Departamentos',
    description: 'Los 32 departamentos de Colombia',
    path: 'Department',
    icon: Icons.map,
    color: Colors.indigo,
    fromJson: Department.fromJson,
    sortByTitle: true,
  ),
  EndpointConfig(
    key: 'presidents',
    title: 'Presidentes',
    description: 'Historia presidencial del país',
    path: 'President',
    icon: Icons.account_balance,
    color: Colors.teal,
    fromJson: President.fromJson,
  ),
  EndpointConfig(
    key: 'attractions',
    title: 'Atractivos turísticos',
    description: 'Lugares para visitar',
    path: 'TouristicAttraction',
    icon: Icons.landscape,
    color: Colors.orange,
    fromJson: TouristicAttraction.fromJson,
    sortByTitle: true,
  ),
  EndpointConfig(
    key: 'dishes',
    title: 'Platos típicos',
    description: 'Gastronomía colombiana',
    path: 'TypicalDish',
    icon: Icons.restaurant,
    color: Colors.redAccent,
    fromJson: TypicalDish.fromJson,
    sortByTitle: true,
  ),
];

EndpointConfig? findEndpoint(String key) {
  for (final e in endpoints) {
    if (e.key == key) return e;
  }
  return null;
}