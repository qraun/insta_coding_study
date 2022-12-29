import 'dart:io';

import 'package:flutter/material.dart';

class SharedPostScreen extends StatelessWidget {

  final File imageFile;

  const SharedPostScreen(this.imageFile, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Image.file(imageFile);
  }
}
