import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiColombiaService {
  final http.Client _client;
  ApiColombiaService({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> _get(String path) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/$path');
    try {
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else if (response.statusCode == 404) {
        throw ApiException('Recurso no encontrado (404)', 404);
      } else if (response.statusCode >= 500) {
        throw ApiException(
            'Error del servidor (${response.statusCode}). Intenta más tarde.',
            response.statusCode);
      } else {
        throw ApiException(
            'Error inesperado (${response.statusCode})', response.statusCode);
      }
    } on http.ClientException {
      throw ApiException('Sin conexión a internet');
    } on TimeoutException {
      throw ApiException('La solicitud tardó demasiado. Intenta de nuevo.');
    } on FormatException {
      throw ApiException('Respuesta inválida del servidor');
    }
  }

  Future<List<T>> getList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await _get(endpoint);
    return (data as List)
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<T> getById<T>(
    String endpoint,
    int id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await _get('$endpoint/$id');
    return fromJson(data as Map<String, dynamic>);
  }
}