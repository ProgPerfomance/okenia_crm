import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/blog_entity.dart';
import '../../edit_blog_viewmodel.dart';

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
