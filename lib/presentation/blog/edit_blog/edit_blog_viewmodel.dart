import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:okenia_crm/data/blog_repository.dart';
import 'package:okenia_crm/di.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';
import 'package:okenia_crm/domain/entities/blog_entity.dart';
import 'package:path/path.dart' as p;
import '../../../data/products_repository.dart';

class EditBlogViewmodel extends ChangeNotifier {


  BlogRepository blogRepository = getIt<BlogRepository>();

  List<BlogModule> modules = [];

  void saveChanges() {
    notifyListeners();
  }

  void addModule(BlogModule module) {
    modules.add(module);
    notifyListeners();
  }

  int selectedIndex = 0;

  void selectElement(index) {
    selectedIndex = index;
    notifyListeners();
  }

  void reorder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final BlogModule item = modules.removeAt(oldIndex);
    modules.insert(newIndex, item);
    notifyListeners();
  }

  bool blocksMenuVisible = false;

  void changeBlocksMenuVisible() {
    blocksMenuVisible = !blocksMenuVisible;
    notifyListeners();
  }

  final List<File> _images = [];

  List<File> get images => _images;


  Future<List<String>> pickAndUploadMultipleImages() async {
    final typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'png'],
    );

    final files = await openFiles(acceptedTypeGroups: [typeGroup]);

    if (files.isEmpty) return [];

    final List<String> uploadedUrls = [];

    for (final file in files) {
      final extension = p.extension(file.path).replaceFirst('.', '');
      final base64Image = base64Encode(File(file.path).readAsBytesSync());

      final resp = await _dio.post(
        '$baseUrl/photos/add',
        data: {'imageString': base64Image, 'imageType': extension},
      );
      uploadedUrls.add(resp.data['image']);
    }


    notifyListeners();

    return uploadedUrls;
  }

  Dio _dio = Dio();

  Future<String?> pickAndUploadImage() async {
    final typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'png'],
    );

    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      final extension = p.extension(file.path).replaceFirst('.', '');
      final resp = await _dio.post(
        '$baseUrl/photos/add',
        data: {
          'imageString': base64Encode(File(file.path).readAsBytesSync()),
          'imageType': extension,
        },
      );
      return resp.data['image'];
    }

    return null;
  }


  Future<void> createPost ({required String humanUrl,required String title}) async {
  await  blogRepository.createBlog(BlogEntity(title: title, body: modules, author: AuthorEntity(firstName: '', lastName: '',id: ''), languageA3Code: 'deu', tags: [],humanUrl: humanUrl));
  }

}
