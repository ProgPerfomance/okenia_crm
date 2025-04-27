import 'package:flutter/material.dart';

TextEditingController _bodyController = TextEditingController();

class BodyWindow extends StatelessWidget {
  const BodyWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextField(
              controller: _bodyController,
            ),
          ),
          SizedBox(height: 48,),
          Center(
            child: TextButton(onPressed: () {}, child: Text('Добавить')),
          )
        ],
      ),
    );
  }
}
