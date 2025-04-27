import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/recept/recept_viewmodel.dart';
import 'package:provider/provider.dart';

class ImageWindow extends StatelessWidget {
  const ImageWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ReceptViewmodel>(context, listen: false);

    return FutureBuilder<String?>(
      future: viewmodel.pickAndUploadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final imageUrl = snapshot.data ?? '';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Добавить изображение'),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final newImage = await viewmodel.pickAndUploadImage();
                    if (newImage != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ImageWindow(),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 150,
                    height: 130,
                    child: imageUrl.isNotEmpty
                        ? Image.network(imageUrl, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    if (imageUrl.isNotEmpty) {
                      Navigator.pop(context);
                      viewmodel.addElement(
                        BlockReceptEntity(
                          type: 'img',
                          widget: Image.network(imageUrl, height: 130),
                          content: imageUrl,
                        ),
                      );
                    }
                  },
                  child: const Text('Добавить'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
