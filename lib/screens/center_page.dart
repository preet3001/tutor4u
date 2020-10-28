import 'package:flutter/material.dart';
import 'package:tutor4u/screens/profile_page.dart';
import 'home.dart';

class CenterPage extends StatefulWidget {
  static const String id = 'centerpage';
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  PageController _pagecontroler = PageController();
  // ignore: non_constant_identifier_names
  List<Widget> _Screens = [home_Page(), Profile_Page()];
  int selectedindex = 0;
  void onpagechanged(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  void onitemchanged(int selectedindex) {
    _pagecontroler.jumpToPage(selectedindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pagecontroler,
        children: _Screens,
        onPageChanged: onpagechanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onitemchanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: selectedindex == 0 ? Colors.blue : Colors.grey,
            ),
            title: Text( // ignore: deprecated_member_use
              'Home',
              style: TextStyle(
                color: selectedindex == 0 ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
              color: selectedindex == 1 ? Colors.blue : Colors.grey,
            ),
            // ignore: deprecated_member_use
            title: Text(
              'Profile',
              style: TextStyle(
                color: selectedindex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
