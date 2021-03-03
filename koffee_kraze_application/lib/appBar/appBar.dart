import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'Koffee Kraze',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 30.00,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          color: Colors.grey,
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            color: Colors.grey,
            icon: Icon(Icons.notifications_none),
            iconSize: 30.0,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        })
      ],
    );
  }
}