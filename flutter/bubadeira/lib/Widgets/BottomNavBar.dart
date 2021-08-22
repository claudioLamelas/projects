import 'package:bubadeira/Common/Constant.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.activeIndex,
  }) : super(key: key);

  final int activeIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.activeIndex,
      elevation: 0,
      fixedColor: Constant.footer_icon_Color,
      backgroundColor: Constant.footerColor,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          activeIcon: IconButton(
            color: Constant.footer_icon_Color,
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
        ),
        BottomNavigationBarItem(
          label: 'Rules',
          icon: IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/rulesList'),
          ),
          activeIcon: IconButton(
            color: Constant.footer_icon_Color,
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
        ),
        BottomNavigationBarItem(
          label: 'Memories',
          icon: IconButton(icon: Icon(Icons.photo_album), onPressed: () {}),
        ),
      ],
    );
  }
}
