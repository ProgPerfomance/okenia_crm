import 'package:flutter/material.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/di.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';

class ProductsListViewmodel extends ChangeNotifier {

  ProductListDisplayType _productListDisplayType = ProductListDisplayType.grid1xN;
  ProductListDisplayType get productListDisplayType => _productListDisplayType;


  void changeProductListDisplayType (ProductListDisplayType type) {
    _productListDisplayType = type;
    notifyListeners();
  }


  ProductsRepository productsRepository = getIt<ProductsRepository>();

  Future<bool> getAllProducts () async {
   await productsRepository.getAllProducts('ru');
   print('ХУЙ');
   return true;
  }

  List<ProductEntity> get products => productsRepository.products;

}


enum ProductListDisplayType {
  grid3xN,
  grid1xN,
}