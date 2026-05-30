import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:checkpoint_final/src/models/product_model.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchProducts({int limit = 10}) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/products?limit=$limit'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Erro ao buscar produtos (código ${response.statusCode})',
        );
      }
    } on Exception catch (e) {
      throw Exception('Falha na conexão: ${e.toString()}');
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/products/$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return ProductModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception(
          'Produto não encontrado (código ${response.statusCode})',
        );
      }
    } on Exception catch (e) {
      throw Exception('Falha na conexão: ${e.toString()}');
    }
  }
}
