import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';
import 'package:okenia_crm/domain/entities/blog_entity.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/edit_blog_viewmodel.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/add_blog_module.dart';
import 'package:provider/provider.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _humanUrlController = TextEditingController();

class EditBlogView extends StatelessWidget {
  const EditBlogView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<EditBlogViewmodel>(context);
    return FutureBuilder(
      future: viewmodel.getAuthors(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: 'Пирожок с картошкой',
                                labelText: 'Название',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: _humanUrlController,
                              decoration: InputDecoration(
                                hintText: 'post_url',
                                labelText: 'Человеческий URL',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            ExpansionTile(
                              title:
                              viewmodel.selectedAuthor != null ?
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(backgroundImage: NetworkImage(viewmodel.selectedAuthor?.avatarUrl ?? ''),),
                                      SizedBox(width: 8,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(viewmodel.selectedAuthor?.fullName ?? ''),
                                          Text(viewmodel.selectedAuthor?.subTitle??''),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ) : Text('Автор'),
                              children: List.generate(viewmodel.authors.length, (index) {
                                AuthorEntity item = viewmodel.authors[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: InkWell(
                                    onTap: (){
                                      viewmodel.selectAuthor(item);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                           children: [
                                             CircleAvatar(backgroundImage: NetworkImage(item.avatarUrl ?? ''),),
                                             SizedBox(width: 8,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(item.fullName),
                                                 Text(item.subTitle),
                                               ],
                                             )
                                           ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 24),
                            if (viewmodel.modules.isNotEmpty &&
                                viewmodel.selectedIndex >= 0 &&
                                viewmodel.selectedIndex <
                                    viewmodel.modules.length) ...[
                              Text(
                                viewmodel
                                    .modules[viewmodel.selectedIndex]
                                    .runtimeType
                                    .toString(),
                              ),
                              if (viewmodel.modules[viewmodel.selectedIndex]
                                  is PBlog)
                                EditParagraphWindow(
                                  p:
                                      viewmodel.modules[viewmodel.selectedIndex]
                                          as PBlog,
                                ),
                              if (viewmodel.modules[viewmodel.selectedIndex]
                                  is HBlog)
                                EditHeaderWindow(
                                  h:
                                      viewmodel.modules[viewmodel.selectedIndex]
                                          as HBlog,
                                ),
                              if (viewmodel.modules[viewmodel.selectedIndex]
                                  is ImageBlog)
                                EditImageWindow(
                                  image:
                                      viewmodel.modules[viewmodel.selectedIndex]
                                          as ImageBlog,
                                ),
                              if (viewmodel.modules[viewmodel.selectedIndex]
                                  is MultiImageBlog)
                                EditMultiImageWindow(
                                  images:
                                      viewmodel.modules[viewmodel.selectedIndex]
                                          as MultiImageBlog,
                                ),
                            ],
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: BaseButton(
                            title: 'Создать пост',
                            onTap: () {
                              viewmodel.createPost(
                                humanUrl: _humanUrlController.text,
                                title: _titleController.text,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                        ),
                        width: 430,
                        child: ReorderableListView(
                          onReorder: viewmodel.reorder,
                          children: List.generate(viewmodel.modules.length, (
                            index,
                          ) {
                            final item = viewmodel.modules[index];
                            switch (item) {
                              case HeaderBlogModule():
                                return GestureDetector(
                                  key: UniqueKey(),
                                  onLongPress: () {
                                    viewmodel.selectElement(index);
                                  },
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          item.backgroundImage,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.3,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.title,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              case HBlog():
                                return GestureDetector(
                                  key: UniqueKey(),
                                  onLongPress: () {
                                    viewmodel.selectElement(index);
                                  },
                                  child: Text(
                                    item.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              case PBlog():
                                return GestureDetector(
                                  key: UniqueKey(),
                                  onLongPress: () {
                                    viewmodel.selectElement(index);
                                  },
                                  child: Text(
                                    item.text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              case ImageBlog():
                                return GestureDetector(
                                  onTap: () {
                                    viewmodel.selectElement(index);
                                  },
                                  key: UniqueKey(),
                                  child: Image.network(
                                    item.imageUrl,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                );
                              case MultiImageBlog():
                                return SizedBox(
                                  key: UniqueKey(),
                                  height: 200,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewmodel.selectElement(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PageView(
                                        children:
                                            item.imageUrls
                                                .map(
                                                  (v) => Image.network(
                                                    v,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width,
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                  ),
                                );
                            }
                          }),
                        ),
                      ),

                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Column(
                          children: [
                            if (viewmodel.blocksMenuVisible)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AddBlockModuleButton(
                                        title: 'Шапка',
                                        type: HeaderBlogModule,
                                      ),
                                      AddBlockModuleButton(
                                        title: 'Заголовок',
                                        type: HBlog,
                                      ),
                                      AddBlockModuleButton(
                                        title: 'Параграф',
                                        type: PBlog,
                                      ),
                                      AddBlockModuleButton(
                                        title: 'Картинка',
                                        type: ImageBlog,
                                      ),
                                      AddBlockModuleButton(
                                        title: 'Карусель картинок',
                                        type: MultiImageBlog,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(height: 8),
                            BaseButton(
                              title: 'Новый блок',
                              onTap: () {
                                viewmodel.changeBlocksMenuVisible();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

// Stack(children: [
//                 BaseButton(title: 'Новый блок', onTap: (){}),
//                 Material(
//                   elevation: 12,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Шапка'),
//                           SizedBox(height: 12,),
//                           Divider(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ]),

class EditParagraphWindow extends StatelessWidget {
  PBlog p;
  EditParagraphWindow({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
      text: p.text,
    );
    final viewmodel = Provider.of<EditBlogViewmodel>(context, listen: false);
    return Column(
      children: [
        TextField(controller: _controller, maxLines: 10, minLines: 1),
        TextButton(
          onPressed: () {
            p.text = _controller.text;
            viewmodel.saveChanges();
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}

class EditHeaderWindow extends StatelessWidget {
  HBlog h;
  EditHeaderWindow({super.key, required this.h});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
      text: h.text,
    );
    final viewmodel = Provider.of<EditBlogViewmodel>(context, listen: false);
    return Column(
      children: [
        TextField(controller: _controller),
        TextButton(
          onPressed: () {
            h.text = _controller.text;
            viewmodel.saveChanges();
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}

class EditImageWindow extends StatelessWidget {
  ImageBlog image;
  EditImageWindow({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    ;
    final viewmodel = Provider.of<EditBlogViewmodel>(context, listen: false);
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            String? img = await viewmodel.pickAndUploadImage();
            if (img != null) {
              image.imageUrl = img;
            }
          },
          child: Text('Загрузить картинку'),
        ),

        TextButton(
          onPressed: () {
            viewmodel.saveChanges();
          },
          child: Text('Обновить'),
        ),
      ],
    );
  }
}

class EditMultiImageWindow extends StatelessWidget {
  MultiImageBlog images;
  EditMultiImageWindow({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    ;
    final viewmodel = Provider.of<EditBlogViewmodel>(context, listen: false);
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            List imgs = await viewmodel.pickAndUploadMultipleImages();
            images.imageUrls = imgs;
          },
          child: Text('Загрузить картинку'),
        ),

        TextButton(
          onPressed: () {
            viewmodel.saveChanges();
          },
          child: Text('Обновить'),
        ),
      ],
    );
  }
}
