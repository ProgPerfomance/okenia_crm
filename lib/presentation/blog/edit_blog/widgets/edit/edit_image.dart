import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/blog_entity.dart';
import '../../edit_blog_viewmodel.dart';

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
