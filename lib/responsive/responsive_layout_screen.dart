import 'package:flutter/material.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) {
          if(constraints.maxWidth > webScreenSize) {//webscreen // hier wird nach größe geschaut. Wenn größer dann webscreen
             return webScreenLayout;
          }
          return mobileScreenLayout;
          //mobile screen

        });
  }
}
