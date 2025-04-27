import 'package:flutter/material.dart';
import 'package:okenia_crm/di.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/edit_blog_viewmodel.dart';
import 'package:okenia_crm/presentation/main_screen/main_view.dart';
import 'package:okenia_crm/presentation/main_screen/main_viewmodel.dart';
import 'package:okenia_crm/presentation/product/new_product/new_product_viewmodel.dart';
import 'package:okenia_crm/presentation/product/open_product/open_product_viewmodel.dart';
import 'package:okenia_crm/presentation/product/products_list/products_list_viewmodel.dart';
import 'package:okenia_crm/presentation/recept/recept_view.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> MainViewmodel()),
        ChangeNotifierProvider(create: (context)=> ProductsListViewmodel()),
        ChangeNotifierProvider(create: (context)=> NewProductViewmodel()),
        ChangeNotifierProvider(create: (context)=> OpenProductViewmodel()),
        ChangeNotifierProvider(create: (context)=> EditBlogViewmodel()),
        ChangeNotifierProvider(create: (context)=> ReceptViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ReceptView(),
      ),
    );
  }
}
