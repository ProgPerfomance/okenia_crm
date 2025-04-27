import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/select_author.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:okenia_crm/presentation/recept/windows/body_window.dart';
import 'package:okenia_crm/presentation/recept/windows/title_window.dart';
import 'package:provider/provider.dart';

final TextEditingController _titleController = TextEditingController();
final TextEditingController _subTitleController = TextEditingController();
final TextEditingController _timeController = TextEditingController();
final TextEditingController _humanUrl = TextEditingController();

class ReceptView extends StatelessWidget {
  const ReceptView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return FutureBuilder(
      future: viewmodel.init(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState != ConnectionState.done) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Expanded(
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
                                    ),
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
                                    SizedBox(height: 12,),
                                    Text('Язык рецепта', style: TextStyle(fontSize: 18),),
                                    SizedBox(height: 12,),
                                    Row(
                                      children: List.generate(locales.length, (index) {
                                        LocaleEntity item = locales[index];
                                        return GestureDetector(onTap: () {
                                          viewmodel.selectLocale(item);
                                        }, child: Container(
                                          decoration: BoxDecoration(
                                            color: viewmodel.selectedLocale.a2value == item.a2value ? Colors.blueAccent : null,
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                                              child: Text(item.toString()),
                                            )));
                                      })
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          TextField(
                            controller: _humanUrl,
                            decoration: const InputDecoration(
                              labelText: 'Человеческий Url',
                            ),
                          ),
                          SizedBox(height: 18,),
                          TagsInput(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddBlockButton(title: 'Заголовок', callback: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> TitleWindow()));
                            }),
                            SizedBox(width: 12,),
                            AddBlockButton(title: 'Параграф', callback: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> BodyWindow()));
                            }),
                            SizedBox(width: 12,),
                            AddBlockButton(title: 'Картинка', callback: () {}),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Expanded(child: ListView(

                        )),
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



class TagsInput extends StatefulWidget {
  const TagsInput({super.key});

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted(String value) {
    if (value.trim().isEmpty) return;
    final viewmodel = Provider.of<ReceptViewmodel>(context, listen: false);
    viewmodel.addTag(value);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...viewmodel.tags.map((tag) => Chip(
          label: Text(tag),
          onDeleted: () => viewmodel.removeTag(tag),
        )),
        SizedBox(
          width: 120,
          child: TextField(
            controller: _controller,
            onSubmitted: _handleSubmitted,
            decoration: const InputDecoration(
              hintText: 'Новый тег',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ),
      ],
    );
  }
}


class AddBlockButton extends StatelessWidget {
  final String title;
  final void Function() callback;
  const AddBlockButton({super.key, required this.title,required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        height: 48,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
