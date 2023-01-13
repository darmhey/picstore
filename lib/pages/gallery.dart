import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/bloc.dart';
import 'package:picstore/components/my_button.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
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
              // final image = await picker.pickImage(
              //   source: ImageSource.gallery,
              // );
              // if (image == null) {
              //   return;
              // }
              // context.read<AppBloc>().add(
              //       AppEventUploadImage(
              //         filePathToUpload: image.path,
              //       ),
              //     );
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          // PopupMenuButton(itemBuilder: (BuildContext context) {
          //   return Container();
          // });),
        ],
      ),
      body: Center(
          child: SizedBox(
        height: 70,
        width: 200,
        child: MyButton(
          buttonText: 'Sign Out',
          onTap: () {
            context.read<AuthBloc>().add(
                  const SignOutAuthEvent(),
                );
          },
        ),
      )),
    );
  }
}
