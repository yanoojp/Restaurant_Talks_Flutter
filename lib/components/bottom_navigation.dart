import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import '../pages/chat.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.screenId});
  final int screenId;

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
            MaterialPageRoute(builder: (context) => ItemIndex()),
          );
        } else if (_selectedIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chat()),
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
