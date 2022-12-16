import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import 'package:restaurant_talks_flutter/pages/sign_up.dart';

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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemIndex()),
                        );
                        print("SignUpボタンが押されました");
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
