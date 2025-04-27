import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/blog/edit_blog/widgets/select_author.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:provider/provider.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _subTitleController = TextEditingController();
TextEditingController _timeController = TextEditingController();

class ReceptView extends StatelessWidget {
  const ReceptView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width:130, height: 130,child: Image(image: NetworkImage(''),height: 100,width: 100,)),
                    SizedBox(width: 24,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              label: Text('Название'),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text('Под заголовок'),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text('Время приготовления (мин)'),
                            ),
                          ),
                          SizedBox(height: 24,
                          ),
                          SelectAuthor(viewmodel: viewmodel),
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          ],
        ),
      )),
    );
  }
}
