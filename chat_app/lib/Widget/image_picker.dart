import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
    PickImage({super.key,required this.onPickImage});


  void Function(File pickimagefile) onPickImage;
  @override
  State<PickImage> createState() => _PickImageState();
}



class _PickImageState extends State<PickImage> {
File? pickedImageFile;


  void _getimage() async{
   final pickedimage=await ImagePicker().pickImage(source:
    ImageSource.gallery,maxWidth: 150);
    setState(() {
       if (pickedimage!=null) {
 pickedImageFile=File(pickedimage.path);
    }
    });
widget.onPickImage(pickedImageFile!);

  }

  @override
  Widget build(BuildContext context) {
    return Column
    (
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:pickedImageFile!=null ? FileImage(pickedImageFile!):null,
        ),
        TextButton.icon
        (icon: const  Icon(Icons.image),
        label: const  Text("Add Image"),

          onPressed: _getimage,)
      ],
    );
  }
}