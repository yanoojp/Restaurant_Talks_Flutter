import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/login_page.dart';
import '../components/Header.dart';
import '../fixedDatas/datas.dart';
import 'item_index.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late int _selectedPositionValue;
  late String selectedPrefectureValue;

  @override
  void initState() {
    super.initState();

    // ポジションと都道府県の初期値を設定
    _selectedPositionValue = positions[0]['positionId'] as int;
    selectedPrefectureValue = prefectures[0]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'サインアップ画面',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'メールアドレス'
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'パスワード'
                  ),
                ),
                /* ポジション選択ドロップダウン　*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 115,
                        child: Text('ポジションを選択', textAlign: TextAlign.center,)
                    ),
                    DropdownButton(
                      items: positions.map((list) => DropdownMenuItem(
                                value: list['positionId'],
                                child: Text(list['positionName'] as String)
                              )).toList(),
                      value: _selectedPositionValue,
                      onChanged: (value) => {
                        setState(() {
                          _selectedPositionValue = value as int;
                        }),
                      },
                    )
                  ],
                ),
                /* 都道府県選択ドロップダウン　*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 115,
                        child: Text('都道府県を選択', textAlign: TextAlign.center,)
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ItemIndex(
                                loginStatus: _selectedPositionValue,
                                prefectureName: selectedPrefectureValue)
                            ),
                          );
                          print("SignUpボタンが押されました。県名：$selectedPrefectureValue");
                        },
                      ),
                      ElevatedButton(
                        child: const Text('ログイン画面へ'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                          print("Login画面へボタンが押されました");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
