import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/item_index.dart';
import 'package:restaurant_talks_flutter/pages/sign_up.dart';
import 'package:restaurant_talks_flutter/utils/authentication.dart';
import 'package:restaurant_talks_flutter/utils/firestore/users.dart';
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
  final List<DropdownMenuItem<int>> _items = [];
  int _selectedPositionValue = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setItems();
    _selectedPositionValue = _items[0].value!;
  }

  void setItems() {
    _items
      ..add(const DropdownMenuItem(
        value: 1,
        child: Text(kitchen),
      ),)
      ..add(const DropdownMenuItem(
        value: 2,
        child: Text(hall),
      ),);
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
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                loginScreen,
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
              controller: emailController,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                passwordLabel,
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
            ),
            /* ポジション選択ドロップダウン　*/
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    child: const Text(loginButton),
                    onPressed: () async {
                      final result = await Authentication.login(
                          email: emailController.text,
                          password: passwordController.text,);
                      if (result is UserCredential) {
                        final loggedInUserInformation =
                            await UserFirestore.getUser(
                                result.user!.uid, result.user!.email!,);
                        if (loggedInUserInformation != false) {
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
                  ElevatedButton(
                    child: const Text(toSignUpScreen),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
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
