import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import '../components/bottom_navigation.dart';
import '../components/header.dart';
import '../components/save_button_return_to_index.dart';
import '../fixedDatas/datas.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key, required this.loginStatus, required this.guestNumber});
  final int loginStatus;
  final int guestNumber;

  @override
  State<MyPageScreen> createState() => _MyPageState();
}

class _MyPageState extends State<MyPageScreen> {
  final int currentScreenId = myPageId;
  late String selectedPrefectureValue;

  @override
  Widget build(BuildContext context) {
    // 都道府県の初期値を設定
    selectedPrefectureValue = prefectures[0]!;

    return Scaffold(
      appBar: Header(
        loginStatus: widget.loginStatus,
        guestNumber: widget.guestNumber,
        currentScreenId: currentScreenId,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                myPageScreen,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: titleFontSize,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                emailLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                user['email'] = text;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Text(
                hotelNameLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                user['hotelName'] = text;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Text(
                nameOfRepresentativeLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                user['nameOfRepresentative'] = text;
              },
            ),
            /* 都道府県選択ドロップダウン　*/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 115,
                      child: Text(choosePrefecture, textAlign: TextAlign.center,)
                  ),
                  DropdownButton(
                      items: prefectures
                          .map((list) => DropdownMenuItem(
                          value: list,
                          child: Text(list)
                      )).toList(),
                      value: selectedPrefectureValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedPrefectureValue = value!;
                        });
                      }
                  )
                ],
              ),
            ),
            SaveButton(loginStatus: widget.loginStatus, guestNumber: widget.guestNumber,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        screenId: currentScreenId,
        loginStatus: widget.loginStatus,
        guestNumber: widget.guestNumber,
        currentScreenId: currentScreenId,
      ),
    );
  }
}
