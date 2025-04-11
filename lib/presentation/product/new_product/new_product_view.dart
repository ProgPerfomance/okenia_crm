import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/product_entity.dart';
import 'new_product_viewmodel.dart';


TextEditingController _nameController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _storageConditionsController = TextEditingController();
TextEditingController _usageRecommendationsController = TextEditingController();
TextEditingController _weigthController = TextEditingController();

class NewProductView extends StatelessWidget {
  const NewProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<NewProductViewmodel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (viewmodel.imageUrls.isNotEmpty)
                    SizedBox(
                      height: 230,
                      width: 230,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            Image.network(
                              viewmodel.imageUrls[0],
                              fit: BoxFit.cover,
                              height: 230,
                              width: 230,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                onPressed: () {
                                  viewmodel.deleteImage(0);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (viewmodel.imageUrls.isEmpty)
                    LoadImagesButton(
                      child: Container(
                        height: 230,
                        width: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Color(0xff808080)),
                        ),
                        child: Center(child: Icon(Icons.add, size: 43)),
                      ),
                    ),

                  const SizedBox(width: 16),
                  // Мини-галерея
                  if (viewmodel.imageUrls.length > 1)
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
                          itemCount: viewmodel.imageUrls.length - 1,
                          itemBuilder:
                              (context, index) => SizedBox(
                                width: 110,
                                height: 110,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        viewmodel.imageUrls[index + 1],
                                        fit: BoxFit.cover,
                                        width: 110,
                                        height: 110,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          viewmodel.deleteImage(index + 1);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Пирожок с картошкой',
                        labelText: 'Название',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: (){
                        if(viewmodel.categoryList.isEmpty) {
                          viewmodel.getCategories();
                        }
                        viewmodel.openCloseCategoryList();
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xfff808080)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(viewmodel.selectedCategory?.name ??'Категория'),
                              Icon(Icons.arrow_forward_ios_sharp)
                            ],
                          ),
                        ),
                      ),
                    ),
                if(viewmodel.openedCategoryList)
                Column(
                      children: List.generate(viewmodel.categoryList.length, (index) {
                        return GestureDetector(
                          onTap: (){
                            viewmodel.selectCategory(viewmodel.categoryList[index]);
                            viewmodel.openCloseCategoryList();
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(viewmodel.categoryList[index].name),
                            ));
                      })
                    ),
                    SizedBox(height: 18),
                    TextField(
                      minLines: 3,
                      maxLines: 10,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        // hintText: 'Пирожок с картошкой',
                        labelText: 'Описание',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextField(
                      minLines: 3,
                      maxLines: 10,
                      controller: _storageConditionsController,
                      decoration: InputDecoration(
                        labelText: 'Условия хранения',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    TextField(
                      minLines: 3,
                      maxLines: 10,
                      controller: _usageRecommendationsController,
                      decoration: InputDecoration(
                        labelText: 'Рекомендации по использованию',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          viewmodel.createProduct(
                            ProductEntity(
                              price: 0,
                              name: _nameController.text,
                              categoryId: viewmodel.selectedCategory?.id,
                              description: _descriptionController.text,
                              tags: [],
                              imageUrls: viewmodel.imageUrls,
                              priceOld: 0,
                              weidth: 0,
                              storageConditions: _storageConditionsController.text,
                              usageRecommendations: _usageRecommendationsController.text,
                              country: 'ru',
                              langAlpha3Code: 'ru',
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff315363),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12,
                            ),
                            child: Text(
                              'Создать',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadImagesButton extends StatelessWidget {
  final Widget child;
  const LoadImagesButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final _viewmodel = Provider.of<NewProductViewmodel>(context);
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder:
              (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  height: 430,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xff808080),
                      width: 0.5,
                    ),
                  ),
                  child: Consumer<NewProductViewmodel>(
                    builder: (context, viewmodel, _) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 230,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 1,
                                    ),
                                itemCount: viewmodel.images.length,
                                itemBuilder:
                                    (context, index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        viewmodel.images[index],
                                        fit: BoxFit.cover,
                                        width: 110,
                                        height: 110,
                                      ),
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    viewmodel.pickImages();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff315363),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Выбрать',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                InkWell(
                                  onTap: () async {
                                    await _viewmodel.loadImagesToServer();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff315363),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Сохранить',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
        );
      },
      child: child,
    );
  }
}
