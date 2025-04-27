import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recept_viewmodel.dart';

final TextEditingController _bodyController = TextEditingController();

class BodyWindow extends StatelessWidget {
  const BodyWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить текст'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Введите текст...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final text = _bodyController.text.trim();
                    if (text.isNotEmpty) {
                      viewmodel.addElement(
                        BlockReceptEntity(
                          type: 'p',
                          widget: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          content: text,
                        ),
                      );
                      _bodyController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Добавить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
