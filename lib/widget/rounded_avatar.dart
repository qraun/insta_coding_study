import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {

  final double size;

  const RoundedAvatar({
    Key? key,
    this.index=101, this.size=avatar_size,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipOval( //이미지 동그랗게
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/${index + 10}/100/100',
        width: size,
        height: size,
      ),
    );
  }
}