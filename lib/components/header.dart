import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import '../pages/guest_number_form.dart';
import '../pages/login_page.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, required this.loginStatus, required this.guestNumber, required this.currentScreenId});
  final int loginStatus;
  final int guestNumber;
  final int currentScreenId;
  final String title = 'Restaurant Talks Flutter';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      leading: currentScreenId != itemIndexId
          ? IconButton(
              onPressed: (){Navigator.of(context).pop();},
              icon: Icon(Icons.arrow_back)
            )
          : null,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    GuestNumberForm(
                        guestNumber: guestNumber,
                        loginStatus: loginStatus
                    )),
              );
            },
            child: Text(
              '残り\n$guestNumber',
              textAlign: TextAlign.center,
            ),
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