import 'package:flutter/material.dart';
import 'package:okenia_crm/domain/entities/author_entity.dart';
import 'package:okenia_crm/domain/entities/blog_entity.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/edit_blog_viewmodel.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/add_blog_module.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/edit/edit_header.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/edit/edit_image.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/edit/edit_multi_image.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/edit/edit_paragraph.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/select_author.dart';
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
                            SelectAuthor(viewmodel: viewmodel),
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
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
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
class EditableTextBlock extends StatefulWidget {
  final String text;

  const EditableTextBlock({super.key, required this.text});

  @override
  State<EditableTextBlock> createState() => _EditableTextBlockState();
}

class _EditableTextBlockState extends State<EditableTextBlock> {
  final GlobalKey _selectableTextKey = GlobalKey();
  TextSelection? _selection;
  String get text => widget.text;

  void _applyBlueStyle() {
    final selection = _selection;
    if (selection == null || selection.isCollapsed) return;

    final selected = text.substring(selection.start, selection.end);
    final before = text.substring(0, selection.start);
    final after = text.substring(selection.end);

    final newText = '$before<a>$selected</a>$after';

    // Просто обновим отображение — не меняем modules[index]
    setState(() {
      _selection = null;
    });

    print('💙 Новый текст с ссылкой: $newText');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final position = overlay.localToGlobal(details.globalPosition);

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
          items: [
            PopupMenuItem(
              child: Text("Сделать ссылкой"),
              onTap: _applyBlueStyle,
            )
          ],
        );
      },
      child: SelectableText(
        widget.text,
        key: _selectableTextKey,
        onSelectionChanged: (selection, cause) {
          setState(() {
            _selection = selection;
          });
        },
      ),
    );
  }
}
