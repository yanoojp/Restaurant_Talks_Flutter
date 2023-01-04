import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/form_with_label_for_login.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import 'package:restaurant_talks_flutter/pages/sign_up.dart';

import '../fixedDatas/variables.dart';

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
        child: Text(kitchen),
        value: 1,
      ))
      ..add(const DropdownMenuItem(
        child: Text(hall),
        value: 2,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  loginScreen,
                  style: TextStyle(
                    fontSize: titleFontSize,
                  ),
                ),
              ),
              const FormWithLabelForLogin(labelText: emailLabel,),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: FormWithLabelForLogin(labelText: passwordLabel,),
              ),
              /* ポジション選択ドロップダウン　*/
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 115,
                        child: const Text(choosePosition, textAlign: TextAlign.center,)
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text(loginButton),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemIndex(
                            loginStatus: _selectedPositionValue,
                            prefectureName: '東京',
                            guestNumber: 10,)
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text(toSignUpScreen),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
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
