import 'package:flutter/material.dart';

class NoDrawerTopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            'Koffee Kraze',
            style: TextStyle(
              color: Colors.brown,
              fontSize: 30.00,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ]
      )

    );
  }
}