import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }


//der onPageChanged gibt der variable die ich zum farbwechsel in den Tabbaritems in der colorchooser function benutze die Value um sie dann zu highlighten.
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  colorChoser(i) {
    return _page == i ? primaryColor : secondaryColor;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //the pageview widget is connected to the pagecontroller. Den ich mit der Tabbar(bottom) verbunden habe. So wird die liste der tabbar items der liste der PageView items zugeordnet. 1=1 2=2 etc.
      body: PageView(
        children: [
          Center(child: Text('Home')),
          Center(child: Text('Search')),
          Center(child: Text('Post')),
          Center(child: Text('Favorites')),
          Center(child: Text('Profile')),
        ],
        //da instagram kein swiping zum navigieren hat müsste ich es hier ausstellen.
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: colorChoser(0)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: colorChoser(1)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: colorChoser(2)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: colorChoser(3)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: colorChoser(4)),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
