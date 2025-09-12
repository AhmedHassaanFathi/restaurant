import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:restaurant/core/utils/app_colors.dart';


class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  ProfileImagePickerState createState() => ProfileImagePickerState();
}

class ProfileImagePickerState extends State<ProfileImagePicker> {
  Uint8List? _pickedProfileImageBytes;
  final String _initials = 'AB';
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _pickedProfileImageBytes == null
                  ? AppColors.black
                  : AppColors.white,
              shape: BoxShape.circle,
              image: _pickedProfileImageBytes != null
                  ? DecorationImage(
                image: MemoryImage(_pickedProfileImageBytes!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _pickedProfileImageBytes == null
                ? Text(
              _initials,
              style:
              Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white),
            )
                : null,
          ),
          Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          InkWell(
            onTap: () async {
              FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
              if (result != null) {
                setState(() {
                  _pickedProfileImageBytes = result.files.first.bytes;
                });
              }
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      
    );
  }


}
