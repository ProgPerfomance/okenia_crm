import 'package:dio/dio.dart';
import 'package:okenia_crm/data/products_repository.dart';
import 'package:okenia_crm/domain/entities/blog_entity.dart';

class BlogRepository {
Dio dio = Dio();
  Future<void> createBlog(BlogEntity blog) async {
    final response = await dio.post('$baseUrl/blog/create',data: blog.createJson());
  }

}