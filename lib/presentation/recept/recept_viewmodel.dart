import 'package:flutter/material.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';

import '../../data/authors_repository.dart';
import '../../di.dart';

class ReceptViewmodel extends ChangeNotifier {
  AuthorsRepository authorsRepository = getIt<AuthorsRepository>();
  final ProductsRepository _productsRepository = getIt<ProductsRepository>();
  AuthorEntity? selectedAuthor;

  void selectAuthor(AuthorEntity author) {
    selectedAuthor = author;
    notifyListeners();
  }

  List<AuthorEntity> get authors => authorsRepository.authors;
  List<ProductEntity> get products => _productsRepository.products;

  Future<bool> getAuthors () async {
    await authorsRepository.getAllAuthors();
    return true;
  }

  Future<bool> getProducts () async {
    await _productsRepository.getAllProducts('deu');
    return true;
  }

  Future<bool> init() async {
    await getProducts();
    await getAuthors();
    return true;
  }

  ProductEntity? selectedProduct;


  void selectProduct(ProductEntity product) {
    selectedProduct = product;
    notifyListeners();
  }

}

