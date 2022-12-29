import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:insta_two/models/gallery_state.dart';
import 'package:insta_two/shared_post/shared_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
            crossAxisCount: 3, children: getImages(context, galleryState));
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    return galleryState.images!
        .map((localImage) => InkWell(
              onTap: () async {
                Uint8List bytes = await localImage.getScaledImageBytes(
                    galleryState.localImageProvider!, 0.3);

                final String timeInMilli =
                    DateTime.now().microsecondsSinceEpoch.toString();
                try {
                  final path = join(
                      (await getTemporaryDirectory()).path, '$timeInMilli.png');
                  File imageFile = File(path)..writeAsBytesSync(bytes);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SharedPostScreen(imageFile)));
                } catch (e) {}
              },
              child: Image(
                image: DeviceImage(localImage),
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }
}
