import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import '../pages/chat_room.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.screenId, required this.loginStatus, required this.guestNumber});
  final int screenId;
  final int loginStatus;
  final int guestNumber;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.screenId;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

        if (_selectedIndex == widget.screenId) {
          return;
        } else if (_selectedIndex == 0) {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: ItemIndex(
                  loginStatus: widget.loginStatus,
                  prefectureName: '東京',
                  guestNumber: widget.guestNumber,
                )
            )
          );
        } else if (_selectedIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom(loginStatus: widget.loginStatus, guestNumber: widget.guestNumber,)),
          );
        }
      });
    }

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'アイテム一覧',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'チャット',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
