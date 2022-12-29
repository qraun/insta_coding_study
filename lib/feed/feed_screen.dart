// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/feed/widget/post.dart';
import 'package:insta_two/repo/user_network_repository.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(CupertinoIcons.photo_camera_solid, color: Colors.black87),
        ),
        middle: Text(
          'instagram',
          style: TextStyle(fontFamily: 'VeganStyle', color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
              },
              icon: ImageIcon(AssetImage("assets/images/actionbar_camera.png"),
              color: Colors.black87,),
            ),
            IconButton(
              onPressed: () {
              },
              icon: ImageIcon(AssetImage("assets/images/direct_message.png"),
                color: Colors.black87,),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: feedListBuilder,
        itemCount: 30,
      ),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}


