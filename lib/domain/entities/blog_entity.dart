import 'package:flutter/cupertino.dart';

import 'author_entity.dart';

class BlogEntity {
  final String? id;
  final String? humanUrl;
  final String title;
  final String languageA3Code;
  final List<BlogModule> body;
  final String? createdAt;
  AuthorEntity author;
  final List<BlogTagEntity> tags;
  BlogEntity({
    this.id,
    required this.title,
    required this.body,
    required this.author,
    this.createdAt,
    required this.languageA3Code,
    required this.tags,
    required this.humanUrl,
  });

  Map createJson () {
    return {
      'title': title,
      'humanUrl': humanUrl,
      'languageA3Code': languageA3Code,
      'authorId': author.id,
      'body': List.generate(body.length, (index) {
        final item = body[index];
        switch(item) {
          case HeaderBlogModule():
            return {
              'type': 'header',
              'text': item.title,
              'image': item.backgroundImage,
            };
          case HBlog():
            return {
              'type': 'h1',
              'text': item.text,
            };
          case PBlog():
            return {
              'type': 'p',
              'text': item.text,
            };
          case ImageBlog():
            return {
              'type': 'img',
              'image': item.imageUrl,
            };
          case MultiImageBlog():
            return {
              'type': 'multi_img',
              'list': item.imageUrls,
            };
        }
      }),
    };
  }



}


class BlogTagEntity {
  final String id;
  final String name;
  BlogTagEntity({required this.id, required this.name});
}

sealed class BlogModule {
  const BlogModule();
}

class HeaderBlogModule extends BlogModule {
  final String title;
  final String backgroundImage;

  const HeaderBlogModule({
    required this.title,
    required this.backgroundImage,
  });
}


class HBlog extends BlogModule {
   String text;
  HBlog({required this.text});
}

class PBlog extends BlogModule {
   String text;
  PBlog({required this.text});
}

class ImageBlog extends BlogModule {
   String imageUrl;
  ImageBlog({required this.imageUrl});
}

class MultiImageBlog extends BlogModule {
   List imageUrls;
  MultiImageBlog({required this.imageUrls});
}