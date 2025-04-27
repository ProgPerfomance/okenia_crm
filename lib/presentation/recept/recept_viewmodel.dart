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

  List<String> tags = [];

  void addTag(String tag) {
    if (tag.trim().isEmpty) return;
    tags.add(tag.trim());
    notifyListeners();
  }

  void removeTag(String tag) {
    tags.remove(tag);
    notifyListeners();
  }

  List<AuthorEntity> get authors => authorsRepository.authors;
  List<ProductEntity> get products => _productsRepository.products;

  Future<bool> getAuthors() async {
    await authorsRepository.getAllAuthors();
    return true;
  }

  Future<bool> getProducts() async {
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

  LocaleEntity selectedLocale = locales[0];

  void selectLocale(LocaleEntity locale) {
    selectedLocale = locale;
    notifyListeners();
  }

  List<BlockReceptEntity> blocks = [];

  void addElement(BlockReceptEntity ent) {
    blocks.add(ent);
    notifyListeners();
  }

  void deleteElement(int index) {
    blocks.removeAt(index);
    notifyListeners();
  }

}

class BlockReceptEntity {

  final String type;
  final Widget widget;
  final String content;
  BlockReceptEntity({
    required this.type,
    required this.widget,
    required this.content,
});

}

class LocaleEntity {
  final String title;
  final String a2value;
  LocaleEntity({
    required this.title,
    required this.a2value,
});

  @override
  String toString() {
    // TODO: implement toString
    return title;
  }

}


List<LocaleEntity> locales = [
  LocaleEntity(title: 'Немецкий', a2value: "de"),
  LocaleEntity(title: 'Английский', a2value: "en"),
  LocaleEntity(title: 'Португальский', a2value: "pt"),
  LocaleEntity(title: 'Русский', a2value: "ru"),
];