import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import 'package:restaurant_talks_flutter/pages/sign_up.dart';
import 'package:weather/weather.dart';

import '../components/Header.dart';
import '../fixedDatas/api_keys.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectedPositionValue = 0;

  @override
  void initState() {
    super.initState();
    setItems();
    _selectedPositionValue = _items[0].value!;
  }

  void setItems() {
    _items
      ..add(const DropdownMenuItem(
        child: Text('キッチン',),
        value: 1,
      ))
      ..add(const DropdownMenuItem(
        child: Text('ホール',),
        value: 2,
      ));
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
                  'ログイン画面',
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
                    items: _items,
                    value: _selectedPositionValue,
                    onChanged: (value) => {
                      setState(() {
                        _selectedPositionValue = value!;
                      }),
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemIndex(loginStatus: _selectedPositionValue, prefectureName: '東京',)),
                        );
                        print("Loginボタンが押されました");
                      },
                    ),
                    ElevatedButton(
                      child: const Text('サインアップ画面へ'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                        print("ログイン画面へボタンが押されました");
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
