import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';

class ReceptViewmodel extends ChangeNotifier {

  AuthorEntity? selectedAuthor;

  void selectAuthor(AuthorEntity author) {
    selectedAuthor = author;
    notifyListeners();
  }

}

