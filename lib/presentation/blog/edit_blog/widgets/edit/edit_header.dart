import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/blog_entity.dart';
import '../../edit_blog_viewmodel.dart';

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