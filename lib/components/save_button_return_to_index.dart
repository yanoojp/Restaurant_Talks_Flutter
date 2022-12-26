import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../pages/item_index.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.guestNumber, required this.loginStatus});
  final int loginStatus;
  final int guestNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("保存ボタンが押されました");
        Navigator.push(
            context,
            PageTransition(type: PageTransitionType.leftToRight, child: ItemIndex(loginStatus: loginStatus, prefectureName: '東京', guestNumber: guestNumber))
        );
      },
      child: Text('保存する'),
    );
  }
}
