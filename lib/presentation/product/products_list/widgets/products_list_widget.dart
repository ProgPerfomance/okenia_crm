
import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';
import 'package:okenia_crm/presentation/product/products_list/widgets/product_list_card.dart';

class ProductsListWidget extends StatelessWidget {
  final List<ProductEntity> productsList;
  const ProductsListWidget({super.key,required this.productsList});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: productsList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = productsList[index];
          return GestureDetector(
            onTap: () {},
            child: ProductListItem(
              name: product.name,
              imageUrl: product.imageUrls[0],
              description: product.description,
              price: product.weidth.toString(),
            ),
          );
        },
      ),
    );
  }
}
