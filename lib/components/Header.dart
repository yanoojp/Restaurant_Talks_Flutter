import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  final String title = 'Restaurant Talks Flutter';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    int guestNumber = 10;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 15.0),
          child: Text(
            '残り\n${guestNumber}',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ),
            print("ログアウトボタンが押されました")
          },
        ),
      ],
    );
  }
}