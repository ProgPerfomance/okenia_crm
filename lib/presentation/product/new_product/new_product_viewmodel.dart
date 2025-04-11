import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/di.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';
import 'dart:io';
import 'package:path/path.dart' as p;


Dio _dio = Dio();

class NewProductViewmodel extends ChangeNotifier {
  final List<File> _images = [];

  List<File> get images => _images;

  List<String> imageUrls = [];

  Future<void> pickImages() async {
    final typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'png'],
    );

    final files = await openFiles(acceptedTypeGroups: [typeGroup]);

    if (files.isNotEmpty) {
      _images.addAll(files.map((xfile) => File(xfile.path)));
    }
    notifyListeners();
  }

  void deleteImage(index) {
    imageUrls.removeAt(index);
    notifyListeners();
  }

  Future<void> loadImagesToServer () async {
    for(var item in _images) {
      final extension = p.extension(item.path).replaceFirst('.', '');

    final resp = await _dio.post('$baseUrl/photos/add', data: {
        'imageString': base64Encode(item.readAsBytesSync()),
        'imageType': extension,
      });

    imageUrls.add(resp.data['image']);

    }
    notifyListeners();
  }


  ProductsRepository productsRepository = getIt<ProductsRepository>();

Future<void> createProduct(ProductEntity product) async  {
   await productsRepository.createProduct(product);
}

CategoryEntity? selectedCategory;

void selectCategory (CategoryEntity cat) {
  selectedCategory = cat;
  notifyListeners();
}

bool openedCategoryList = false;

void openCloseCategoryList () {
  openedCategoryList = !openedCategoryList;
  notifyListeners();
}


List<CategoryEntity> get categoryList => productsRepository.categories;

Future<void> getCategories () async {
  await productsRepository.getCategories('ru');
  notifyListeners();
}





}


