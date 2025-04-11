

import 'package:get_it/get_it.dart';
import 'package:okenia_crm/data/blog_repository.dart';
import 'package:okenia_crm/data/products_repository.dart';

GetIt getIt = GetIt.instance;


void register() {

  getIt.registerSingleton(ProductsRepository());
  getIt.registerSingleton(BlogRepository());

}