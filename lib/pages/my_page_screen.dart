import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import 'package:restaurant_talks_flutter/utils/authentication.dart';
import 'package:restaurant_talks_flutter/utils/firestore/guestNumber.dart';
import 'package:restaurant_talks_flutter/utils/firestore/users.dart';
import '../components/bottom_navigation.dart';
import '../components/header.dart';
import '../fixedDatas/datas.dart';
import '../model/account.dart';
import 'item_index.dart';
import 'login_page.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key, required this.loginStatus});
  final int loginStatus;

  @override
  State<MyPageScreen> createState() => _MyPageState();
}

class _MyPageState extends State<MyPageScreen> {
  final int currentScreenId = myPageId;
  late String selectedPrefectureValue;
  late Account myAccount;

  TextEditingController emailController = TextEditingController();
  TextEditingController hotelnameController = TextEditingController();
  TextEditingController nameOfRepresentativeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myAccount = Authentication.myAccount!;
    emailController = TextEditingController(text: myAccount.email);
    hotelnameController = TextEditingController(text: myAccount.hotelName);
    nameOfRepresentativeController = TextEditingController(
        text: myAccount.nameOfRepresentative
    );
    selectedPrefectureValue = myAccount.prefecture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        loginStatus: widget.loginStatus,
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
              controller: emailController,
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
              controller: hotelnameController,
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
              controller: nameOfRepresentativeController,
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
            ElevatedButton(
              onPressed: () async{
                Account updateAccount = Account(
                  id: myAccount.id,
                  email: emailController.text,
                  hotelName: hotelnameController.text,
                  nameOfRepresentative: nameOfRepresentativeController.text,
                  prefecture: selectedPrefectureValue,
                );
                Authentication.myAccount = updateAccount;
                var result = await UserFirestore.updateUser(updateAccount);
                if (result == true) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: ItemIndex(
                              loginStatus: widget.loginStatus,
                          )
                      )
                  );
                }
              },
              child: Text(saveButton),
            ),
            TextButton(
              onPressed: () {
                UserFirestore.deleteUser(myAccount.id);
                Authentication.deleteAccount();
                GuestNumberFirestore.deleteGuestNumber(myAccount.id);
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: LoginPage(),
                      isIos: true,
                    )
                );
              },
              child: Text(deleteAccount),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        screenId: currentScreenId,
        loginStatus: widget.loginStatus,
        currentScreenId: currentScreenId,
      ),
    );
  }
}
