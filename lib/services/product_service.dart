import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ProductService {
  static const String _url = 'https://fakestoreapi.com/products';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse(_url))
          .timeout(const Duration(seconds: 10));

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data =
              jsonDecode(response.body) as List<dynamic>;
          return data
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();
        case 404:
          throw ApiException('Ресурс не найден (404)');
        case 500:
          throw ApiException('Ошибка сервера (500)');
        default:
          throw ApiException('Ошибка HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      throw ApiException('Время ожидания истекло (10 сек)');
    } on SocketException {
      throw ApiException('Нет подключения к интернету');
    } on http.ClientException {
      throw ApiException('Нет подключения к интернету');
    } on FormatException {
      throw ApiException('Некорректный ответ сервера');
    }
  }
}
