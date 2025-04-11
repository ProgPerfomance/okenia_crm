import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/product_entity.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'open_product_viewmodel.dart';

class OpenProductView extends StatelessWidget {

  final ProductEntity productEntity;

  const OpenProductView({super.key,required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<OpenProductViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            viewmodel.deleteProducts(productEntity.id);
            Navigator.pop(context);
          }, icon: Icon(Icons.delete,color:Colors.red)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Главное изображение
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    productEntity.imageUrls[0],
                    fit: BoxFit.cover,
                    height: 230,
                    width: 230,
                  ),
                ),
                const SizedBox(width: 16),
                // Мини-галерея
                Expanded(
                  child: SizedBox(
                    height: 230, // Высота = 2 ряда по 110 + отступы
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemCount: productEntity.imageUrls.length-1,
                      itemBuilder:
                          (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              productEntity.imageUrls[index+1],
                              fit: BoxFit.cover,
                              width: 110,
                              height: 110,
                            ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SelectProductInfoWidget(),
            SizedBox(height: 18),
            Text(
              productEntity.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Пирожки с едой', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            ProductOptionWidget(title: 'Масса нетто:', body: '${productEntity.weidth}g'),
            ProductOptionWidget(
              title: 'Описание',
              body:
                  productEntity.description,
            ),
            ProductOptionWidget(title: 'Страна', body: productEntity.country??''),
            ProductOptionWidget(
              title: 'Условия хранения',
              body:
                productEntity.storageConditions??'',
            ),
            ProductOptionWidget(
              title: 'Рекомендации по применению:',
              body:
                productEntity.usageRecommendations??'',
            ),
            Text(
              'Кросс-ссылки',
              style: TextStyle(color: Color(0xff808080), fontSize: 16),
            ),
            CrossLinksList(links: []),
          ],
        ),
      ),
    );
  }
}

class SelectProductInfoWidget extends StatelessWidget {
  const SelectProductInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<OpenProductViewmodel>(context);
    return Row(
      children: [
        InkWell(
          child: Text(
            'О товаре',
            style: TextStyle(
              fontSize: 18,
              decoration:
                  viewmodel.selectedProductBlock == SelectedProductBlock.info
                      ? TextDecoration.underline
                      : null,
            ),
          ),
          onTap: () {
            viewmodel.changeProductBlock(SelectedProductBlock.info);
          },
        ),
        SizedBox(width: 24),
        InkWell(
          child: Text(
            'Метрики',
            style: TextStyle(
              fontSize: 18,
              decoration:
                  viewmodel.selectedProductBlock ==
                          SelectedProductBlock.analytics
                      ? TextDecoration.underline
                      : null,
            ),
          ),
          onTap: () {
            viewmodel.changeProductBlock(SelectedProductBlock.analytics);
          },
        ),
      ],
    );
  }
}

class ProductOptionWidget extends StatelessWidget {
  final String title;
  final String body;
  const ProductOptionWidget({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xff808080), fontSize: 16)),
        SizedBox(height: 8),
        Text(body, style: TextStyle(fontSize: 18)),
        SizedBox(height: 12),
      ],
    );
  }
}

class CrossLinksList extends StatelessWidget {
  final List<CrossLinkEntity> links;
  const CrossLinksList({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        links.length,
        (index) => CrossLinkWidget(link: links[index]),
      ),
    );
  }
}

class CrossLinkWidget extends StatelessWidget {
  final CrossLinkEntity link;
  const CrossLinkWidget({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse(link.url));
          },
          child: Text(
            link.title,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

class CrossLinkEntity {
  final String url;
  final String title;
  CrossLinkEntity({required this.title, required this.url});
}
