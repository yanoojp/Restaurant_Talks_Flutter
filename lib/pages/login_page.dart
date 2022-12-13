import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ログイン画面',
            ),
            ElevatedButton(
              child: const Text('ログインボタン'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemIndex(title: 'Restaurant Talks Flutter')),
                );
                print("loginボタンが押されました");
              },
            ),
          ],
        ),
      )
    );
  }
}
