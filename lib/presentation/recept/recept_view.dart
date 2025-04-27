import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/select_author.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:provider/provider.dart';

final TextEditingController _titleController = TextEditingController();
final TextEditingController _subTitleController = TextEditingController();
final TextEditingController _timeController = TextEditingController();

class ReceptView extends StatelessWidget {
  const ReceptView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return FutureBuilder(
      future: viewmodel.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 130,
                              child: Image.network("", fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: _titleController,
                                    decoration: const InputDecoration(
                                      labelText: 'Название',
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  TextField(
                                    controller: _subTitleController,
                                    decoration: const InputDecoration(
                                      labelText: 'Под заголовок',
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  TextField(
                                    controller: _timeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Время приготовления (мин)',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 24),
                                  SelectAuthor(
                                    viewmodel: viewmodel,
                                  ), // Раскомментировать при наличии виджета
                                  const SizedBox(height: 18),
                                  ExpansionTile(
                                    title:
                                        viewmodel.selectedProduct != null
                                            ? Row(
                                              children: [
                                                SizedBox(
                                                  height: 48,
                                                  width: 48,
                                                  child: Image.network(
                                                    viewmodel
                                                            .selectedProduct!
                                                            .mainImage ??
                                                        "",

                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  viewmodel
                                                          .selectedProduct!
                                                          .name ??
                                                      '',
                                                ),
                                              ],
                                            )
                                            : const Text('Продукт'),
                                    children: List.generate(
                                      viewmodel.products.length,
                                      (index) {
                                        final product =
                                            viewmodel.products[index];
                                        return GestureDetector(
                                          onTap: () {
                                            viewmodel.selectProduct(product);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 48,
                                                  width: 48,
                                                  child: Image.network(
                                                    product.mainImage ?? "",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(product.name ?? ''),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
