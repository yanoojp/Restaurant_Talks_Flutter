import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/login_page.dart';
import 'package:restaurant_talks_flutter/utils/authentication.dart';
import 'package:restaurant_talks_flutter/utils/firestore/guestNumber.dart';
import 'package:restaurant_talks_flutter/utils/firestore/users.dart';
import '../fixedDatas/datas.dart';
import '../fixedDatas/variables.dart';
import '../model/account.dart';
import 'item_index.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late int _selectedPositionValue;
  late String selectedPrefectureValue;

  late String email;
  late String password;
  late String hotelName;
  late String nameOfRepresentative;

  TextEditingController hotelNameController = TextEditingController();
  TextEditingController nameOfRepresentativeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // ポジションと都道府県の初期値を設定
    _selectedPositionValue = positions[0]['positionId'] as int;
    selectedPrefectureValue = prefectures[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                signUpScreen,
                style: TextStyle(
                  fontSize: titleFontSize,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                emailLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                email = text;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: const Text(
                passwordLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                password = text;
              },
              obscureText: true,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: const Text(
                hotelNameLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                hotelName = text;
              },
              controller: hotelNameController,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: const Text(
                nameOfRepresentativeLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (text) {
                nameOfRepresentative = text;
              },
              controller: nameOfRepresentativeController,
            ),
            /* ポジション選択ドロップダウン　*/
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                      width: 115,
                      child: Text(
                        choosePosition,
                        textAlign: TextAlign.center,
                      ),),
                  DropdownButton(
                    items: positions
                        .map((list) => DropdownMenuItem(
                            value: list['positionId'],
                            child: Text(list['positionName'] as String),),)
                        .toList(),
                    value: _selectedPositionValue,
                    onChanged: (value) => {
                      setState(() {
                        _selectedPositionValue = value as int;
                      }),
                    },
                  )
                ],
              ),
            ),
            /* 都道府県選択ドロップダウン　*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                    width: 115,
                    child: Text(
                      choosePrefecture,
                      textAlign: TextAlign.center,
                    ),),
                DropdownButton(
                    items: prefectures
                        .map((list) =>
                            DropdownMenuItem(value: list, child: Text(list)),)
                        .toList(),
                    value: selectedPrefectureValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPrefectureValue = value!;
                      });
                    },)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    child: const Text(signUButton),
                    onPressed: () async {
                      final result = await Authentication.signUp(
                          email: email, password: password,);
                      if (result is UserCredential) {
                        final newAccount = Account(
                          id: result.user!.uid,
                          email: result.user!.email!,
                          hotelName: hotelNameController.text,
                          nameOfRepresentative:
                              nameOfRepresentativeController.text,
                          prefecture: selectedPrefectureValue,
                        );
                        final _result =
                            await UserFirestore.setUser(newAccount, email);
                        if (_result == true) {
                          Authentication.myAccount = newAccount;

                          await GuestNumberFirestore.setGuestNumber(
                              result.user!.uid,);

                          if (!mounted) return;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemIndex(
                                      loginStatus: _selectedPositionValue,
                                    ),),
                          );
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      child: const Text(toLoginScreen),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
