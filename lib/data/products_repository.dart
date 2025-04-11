import 'package:dio/dio.dart';

import '../domain/entities/product_entity.dart';

const String baseUrl = 'https://mvpgarage.one:3700';

class ProductsRepository {
  Dio dio = Dio();
  List<ProductEntity> products = [];
  List<CategoryEntity> categories = [];

  Future<void> getAllProducts(String langAlpha3Code) async {
    try {
      final response = await dio.get('$baseUrl/products/all/$langAlpha3Code');
      if (response.data is List) {
        List data = response.data;
        products = data.map((v) => ProductEntity.fromApi(v)).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProduct(ProductEntity product) async {
    final response = await dio.post(
      '$baseUrl/products/create',
      data: product.createJson(),
    );
  }

  Future<void> deleteProduct(id) async {
    final response = await dio.delete('$baseUrl/products/delete/$id');
  }

  Future<void> getCategories(lang) async {
    final response = await dio.get('$baseUrl/categories/$lang');

    List data = response.data;

    categories = data.map((v) => CategoryEntity.fromApi(v)).toList();
  }
}

class CategoryEntity {
  final String id;
  final String name;
  CategoryEntity({required this.id, required this.name});

  factory CategoryEntity.fromApi(Map map) {
    return CategoryEntity(id: map['_id'], name: map['name']);
  }
}
