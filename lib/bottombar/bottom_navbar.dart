import 'package:flutter/material.dart';
import 'package:mobile_akhir/pages/note.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:mobile_akhir/pages/details.dart';
import 'package:mobile_akhir/pages/komen.dart';
import 'package:mobile_akhir/pages/home.dart';
import 'package:mobile_akhir/pages/info.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final _pageControlller = PageController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageControlller,
          children: const <Widget>[
            Home(),
            Details(),
            Note(),
            Info(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: RollingBottomBar(
          color: Color(0xff88a26a),
          controller: _pageControlller,
          flat: true,
          useActiveColorByDefault: false,
          items: const [
            RollingBottomBarItem(Icons.home,
                label: 'Home', activeColor: Color(0xffedfcdc)),
            RollingBottomBarItem(Icons.list_alt_rounded,
                label: 'List', activeColor: Color(0xffedfcdc)),
            RollingBottomBarItem(Icons.comment_rounded,
                label: 'Komen', activeColor: Color(0xffedfcdc)),
            RollingBottomBarItem(Icons.info_outline_rounded,
                label: 'Info', activeColor: Color(0xffedfcdc)),
          ],
          enableIconRotation: true,
          onTap: (index) {
            _pageControlller.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }
}
