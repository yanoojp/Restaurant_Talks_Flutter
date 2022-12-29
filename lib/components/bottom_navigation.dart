import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import 'package:restaurant_talks_flutter/pages/my_page_screen.dart';
import '../fixedDatas/variables.dart';
import '../pages/chat_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.screenId,
    required this.loginStatus,
    required this.guestNumber
  });

  final int screenId;
  final int loginStatus;
  final int guestNumber;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.screenId;

    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;

        if (selectedIndex == widget.screenId) {
          return;
        } else if (selectedIndex == itemIndexId) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: ItemIndex(
                loginStatus: widget.loginStatus,
                prefectureName: '東京',
                guestNumber: widget.guestNumber,
              ),
              isIos: true,
            )
          );
        } else if (selectedIndex == chatScreenId) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                ChatScreen(
                  loginStatus: widget.loginStatus,
                  guestNumber: widget.guestNumber,
                )
            ),
          );
        } else if (selectedIndex == myPageId) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                MyPageScreen(
                  loginStatus: widget.loginStatus,
                  guestNumber: widget.guestNumber,
                )
            ),
          );
        }
      });
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: itemIndexScreen,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: chatScreen,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: myPageScreen,
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
