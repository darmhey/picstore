import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picstore/auth/bloc/bloc.dart';
import 'package:picstore/pages/storage_image_view.dart';

import '../components/main_popup_menu.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final images = context.watch<AuthBloc>().state.images ?? [];
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[700],
        title: Text(
          'Gallery',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context.read<AuthBloc>().add(
                    AppEventUploadImage(
                      filePathToUpload: image.path,
                    ),
                  );
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: images
            .map(
              (img) => StorageImageView(
                image: img,
              ),
            )
            .toList(),
      ),
    );
  }
}
