import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/constants/common_size.dart';
import 'package:insta_two/constants/screen_size.dart';
import 'package:insta_two/models/camera_state.dart';
import 'package:insta_two/shared_post/shared_post_screen.dart';
import 'package:insta_two/widget/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {

  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: [
            Container(
              width: size!.width,
              height: size!.width,
              color: Colors.black,
              child: (cameraState.isReadyToTakePhoto)
                  ? _getPreview(cameraState)
                  : _progress,
            ),
            Expanded(
              child: OutlinedButton(
                child: Container(width: 90,),
                onPressed: () {
                  if (cameraState.isReadyToTakePhoto) {
                    _attemptTakePhoto(cameraState, context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.black12, width: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: size!.width,
            height: size!.width / cameraState.controller!.value.aspectRatio,
            child: CameraPreview(
                cameraState.controller
            ),
          ),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    try {
      final path = join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      await cameraState.controller!.takePicture(path);

      File imageFile = File(path);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharedPostScreen(imageFile)));
    } catch (e) {

    }
  }
}
