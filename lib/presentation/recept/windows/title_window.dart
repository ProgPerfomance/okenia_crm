import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:provider/provider.dart';

TextEditingController _titleController = TextEditingController();

class TitleWindow extends StatelessWidget {
  const TitleWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: TextField(controller: _titleController)),
          SizedBox(height: 48),
          Center(
            child: TextButton(
              onPressed: () {
                viewmodel.addElement(
                  BlockReceptEntity(
                    type: 'h',
                    widget: Text(_titleController.text),
                    content: _titleController.text,
                  ),
                );
                _titleController.clear();
                Navigator.pop(context);
              },
              child: Text('Добавить'),
            ),
          ),
        ],
      ),
    );
  }
}
