import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';
import 'package:okenia_crm/presentation/product/products_list/widgets/product_card.dart';

import '../../open_product/open_product_view.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> productsList;
  const ProductsGridView({super.key,required this.productsList});

  @override
  Widget build(BuildContext context) {
    return
   LayoutBuilder(
        builder: (context, constraints) {
          const itemWidth = 200.0;
          int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 4 / 3,
            ),
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              final product = productsList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OpenProductView(productEntity: productsList[index],)));
                },
                child: ProductGridCard(
                  name: product.name,
                  imageUrl: product.imageUrls[0],
                ),
              );
            },
          );
        },

    );
  }
}



