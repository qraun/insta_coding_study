// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/constants/common_size.dart';
import 'package:insta_two/constants/screen_size.dart';
import 'package:insta_two/feed/widget/comment.dart';
import 'package:insta_two/widget/my_progress_indicator.dart';
import 'package:insta_two/widget/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postAction(),
        _postLikes(),
        _postCaption(),
        _postEndDiver(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        index: index,
        username: "username ${index+1}",
        showImage: false,
        text: "I have a dream!!!, i need much money",
      ),
    );
  }

  Divider _postEndDiver() {
    return Divider(
      height: 1,
      color: Colors.grey[300],
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_xxs_gap),
      child: Text(
        '12000 Likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postAction() {
    return Row(
      children: [
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
          color: Colors.black87,
        ),
        Spacer(),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(index: index),
        ),
        Expanded(child: Text('username')),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      //받아놓은 이미지 재사용
      imageUrl: 'https://picsum.photos/id/${index + 20}/2000/2000',
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(containerSize: size!.width);
      },
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
          ),
        );
      },
    );
  }
}
