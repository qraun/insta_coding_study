// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_two/constants/common_size.dart';
import 'package:insta_two/widget/rounded_avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime? dateTime;


  const Comment({
    Key? key,
    required this.index,
    this.showImage = true, required this.username, required this.text, this.dateTime,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage)
          RoundedAvatar(index: index, size: 24),
        if (showImage)
          SizedBox(
            width: common_xxs_gap,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'username111',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextSpan(text: "  "),
                TextSpan(
                  text: 'i love myself!!!!',
                  style: TextStyle(color: Colors.black),
                ),
              ]),
            ),
            if(dateTime != null)
            Text(
              dateTime!.toIso8601String(),
              style: TextStyle(color: Colors.grey[400], fontSize: 10),
            )
          ],
        ),
      ],
    );
  }
}
