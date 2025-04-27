
import 'package:flutter/material.dart';

import '../../../../domain/entities/author_entity.dart';
import '../edit_blog_viewmodel.dart';

class SelectAuthor extends StatelessWidget {
  const SelectAuthor({
    super.key,
    required this.viewmodel,
  });

  final  viewmodel;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
    );
  }
}