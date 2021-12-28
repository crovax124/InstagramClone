import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source, imageQuality: 50);

  if (_file != null) {
    return await _file
        .readAsBytes(); //anstatt File() über dart.io geht das hier auch in der Webversion. weil UInt8 ausgegeben wird.
  }
  print('No Image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
