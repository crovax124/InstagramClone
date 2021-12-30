import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {

    super.initState();
    addData();
  }

  addData() async {
    //damit refreshUser() kein null ausgibt wird die funktion hier ausgeführt. Damit das nur einmal und nicht konstant passiert(listen:false)
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) {
          if(constraints.maxWidth > webScreenSize) {//webscreen // hier wird nach größe geschaut. Wenn größer dann webscreen
             return widget.webScreenLayout;
          }
          return widget.mobileScreenLayout;
          //mobile screen

        });
  }
}
