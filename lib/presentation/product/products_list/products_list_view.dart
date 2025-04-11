import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/product/products_list/products_list_viewmodel.dart';
import 'package:okenia_crm/presentation/product/products_list/widgets/products_grid_widget.dart';
import 'package:okenia_crm/presentation/product/products_list/widgets/products_list_widget.dart';
import 'package:provider/provider.dart';

import '../new_product/new_product_view.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProductsListViewmodel>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Scaffold(
        body: FutureBuilder(
          future: viewmodel.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Color(0xff808080),
                            width: 0.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // ⬅️ это важно
                          children: [
                            IconButton(
                              onPressed: () {
                                viewmodel.changeProductListDisplayType(
                                  ProductListDisplayType.grid3xN,
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.circle_grid_3x3,
                                color:
                                    viewmodel.productListDisplayType ==
                                            ProductListDisplayType.grid3xN
                                        ? Color(0xff315363)
                                        : null,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                viewmodel.changeProductListDisplayType(
                                  ProductListDisplayType.grid1xN,
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.rectangle_grid_1x2,
                                color:
                                    viewmodel.productListDisplayType ==
                                            ProductListDisplayType.grid1xN
                                        ? Color(0xff315363)
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewProductView(),
                            ),
                          );
                        },
                        child: Text('Новый товар'),
                      ),
                    ],
                  ),
                  if (viewmodel.productListDisplayType ==
                      ProductListDisplayType.grid3xN)
                    Expanded(
                      child: ProductsGridView(productsList: viewmodel.products),
                    ),
                  if (viewmodel.productListDisplayType ==
                      ProductListDisplayType.grid1xN)
                    Expanded(
                      child: ProductsListWidget(
                        productsList: viewmodel.products,
                      ),
                    ),
                ],
              );
            }
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
