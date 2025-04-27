import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recept_viewmodel.dart';

TextEditingController _bodyController = TextEditingController();

class BodyWindow extends StatelessWidget {
  const BodyWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: TextField(controller: _bodyController)),
          SizedBox(height: 48),
          Center(
            child: TextButton(
              onPressed: () {
                viewmodel.addElement(
                  BlockReceptEntity(
                    type: 'p',
                    widget: Text(
                      _bodyController.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    content: _bodyController.text,
                  ),
                );
                _bodyController.clear();
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
