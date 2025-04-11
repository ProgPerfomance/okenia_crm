import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/blog_entity.dart';
import '../edit_blog_viewmodel.dart';


class AddBlockModuleButton extends StatelessWidget {
  final dynamic type;
  final String title;
  const AddBlockModuleButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<EditBlogViewmodel>(context, listen: false);
    return InkWell(
      hoverColor: Colors.black,
      onTap: () {
        print(type);
        switch (type) {
          case HeaderBlogModule:
            viewmodel.addModule(
              HeaderBlogModule(title: 'Заголовок шапки', backgroundImage: ''),
            );
        }
        switch (type) {
          case HBlog:
            viewmodel.addModule(HBlog(text: 'Заголовок'));
        }
        switch (type) {
          case PBlog:
            viewmodel.addModule(PBlog(text: 'Параграф'));
        }
        switch (type) {
          case ImageBlog:
            viewmodel.addModule(ImageBlog(imageUrl: ''));
        }
        switch (type) {
          case MultiImageBlog:
            viewmodel.addModule(MultiImageBlog(imageUrls: []));
        }
        viewmodel.changeBlocksMenuVisible();
      },
      child: Container(
        height: 48,
        width: 100,
        color: Colors.white,
        child: Text(title),
      ),
    );
  }
}

class BaseButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final Function onTap;
  final Color? color;
  const BaseButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: height ?? 48,
        width: width ?? 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color ?? Color(0xff315363),
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}