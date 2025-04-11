import 'package:dio/dio.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';

class AuthorsRepository {
  Dio dio = Dio();


  List<AuthorEntity> authors = [];

  Future<void> getAllAuthors() async {
    final response = await dio.get('$baseUrl/authors/all');
    List data = response.data;
    authors = data.map((v) => AuthorEntity.fromApi(v)).toList();
  }




}
