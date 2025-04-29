import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of(context);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(child: ListView.separated(itemBuilder: (context,index) {}, separatorBuilder: (context,index) {
              return SizedBox(height: 12,);
            }, itemCount: 10)),
          ],
        ),
      )),
    );
  }
}
