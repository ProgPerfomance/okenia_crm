import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/blog_entity.dart';
import '../../edit_blog_viewmodel.dart';

class EditMultiImageWindow extends StatelessWidget {
  MultiImageBlog images;
  EditMultiImageWindow({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
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
