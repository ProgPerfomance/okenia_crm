import 'package:flutter/material.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/di.dart';

class OpenProductViewmodel extends ChangeNotifier {

  SelectedProductBlock _selectedProductBlock = SelectedProductBlock.info;
  SelectedProductBlock get selectedProductBlock => _selectedProductBlock;

  ProductsRepository productsRepository = getIt<ProductsRepository>();


  void deleteProducts (id) async {
    await productsRepository.deleteProduct(id);
    await productsRepository.getAllProducts('ru');
    notifyListeners();
  }

  void changeProductBlock (SelectedProductBlock block) {
    _selectedProductBlock = block;
    notifyListeners();
  }

}

enum SelectedProductBlock {
  info,
  analytics,
}

