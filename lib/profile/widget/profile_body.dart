// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_two/constants/common_size.dart';
import 'package:insta_two/constants/screen_size.dart';
import 'package:insta_two/models/user_model_state.dart';
import 'package:insta_two/profile/profile_screen.dart';
import 'package:insta_two/widget/rounded_avatar.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  final Function onMenuChanged;

  const ProfileBody({super.key, required this.onMenuChanged});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size!.width;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            child: CustomScrollView(
              //리스트뷰 하나로 합치기 위해, 리스트뷰 섞어쓸 때
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(common_gap),
                            child: RoundedAvatar(
                              size: 80,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: common_gap),
                              child: Table(
                                children: [
                                  TableRow(children: [
                                    _valueText('83'),
                                    _valueText('200k'),
                                    _valueText('43'),
                                  ]),
                                  TableRow(children: [
                                    _labelText('Post'),
                                    _labelText('Followers'),
                                    _labelText('Following'),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _username(context),
                      _userBio(),
                      _editProfileBtn(),
                      _tabButtons(),
                      _selectedIndicator(),
                    ],
                  ),
                ),
                _imagesPager(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(width: 44),
        Expanded(
            child: Text(
          'The Coding Papa',
          textAlign: TextAlign.center,
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController,
          ),
          onPressed: () {
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed
                ? _iconAnimationController.reverse()
                : _iconAnimationController.forward();
          },
        ),
      ],
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String label) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _imges2(),
          ),
        ],
      ),
    );
  }

  GridView _imges2() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(), //스크롤 무시
      shrinkWrap: true, //모양 유지... 2개일때도
      crossAxisCount: 3,
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: 'https://picsum.photos/id/${index + 51}/100/100'),
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(), //스크롤 무시
      shrinkWrap: true, //모양 유지... 2개일때도
      crossAxisCount: 3,
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: 'https://picsum.photos/id/${index + 11}/100/100'),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: duration,
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size!.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.easeInOut,
    );
  }

  Row _tabButtons() {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage(
                'assets/images/grid.png',
              ),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black
                  : Colors.black26,
            ),
            onPressed: () {
              _tabSelected(SelectedTab.left);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage(
                'assets/images/saved.png',
              ),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black26
                  : Colors.black,
            ),
            onPressed: () {
              _tabSelected(SelectedTab.right);
            },
          ),
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size!.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size!.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: common_xxs_gap, horizontal: common_gap),
      child: SizedBox(
        height: 24,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)))),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _username(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text("username"/*
        Provider.of<UserModelState>(context, listen: false).userModel.username,
        style: TextStyle(fontWeight: FontWeight.bold),*/
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'This is what i believe!!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}

enum SelectedTab { left, right }
