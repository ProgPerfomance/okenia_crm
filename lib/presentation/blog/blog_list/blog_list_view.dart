import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/edit_blog_view.dart';


class BlogListView extends StatelessWidget {
  const BlogListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditBlogView()));
          }, icon: Icon(Icons.add),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(),
      ),
    );
  }
}
