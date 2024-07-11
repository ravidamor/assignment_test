


import 'package:flutter/material.dart';

import '../components/my_theme.dart';

class BackGround extends StatefulWidget {
  const BackGround({super.key});

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration:BoxDecoration(
        gradient:LinearGradient(
          colors: [MyTheme.cyan_with_light_sea_greens.withOpacity(0.2),MyTheme.white,MyTheme.white,MyTheme.white,MyTheme.white,MyTheme.white,MyTheme.cyan_with_light_sea_greens.withOpacity(0.2) ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );
  }
}
