import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:provider/provider.dart';

class ImageWindow extends StatelessWidget {
  const ImageWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context);
    return FutureBuilder(
      future: viewmodel.pickAndUploadImage(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: GestureDetector(child: SizedBox(child: Image.network(snapshot.data ?? ""),width: 150, height:  130), onTap: (){
                viewmodel.pickAndUploadImage();
              },),),
              SizedBox(height: 24,),
              Center(child: TextButton(onPressed: () {
                Navigator.pop(context);
                viewmodel.addElement(BlockReceptEntity(type: 'img', widget: Image.network(snapshot.data ?? "",height: 130,), content: snapshot.data ?? ""));
              }, child: Text('Добавить'))),
            ],
          )),
        );
      }
    );
  }
}
