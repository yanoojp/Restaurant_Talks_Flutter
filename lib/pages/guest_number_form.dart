import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/header.dart';
import '../components/save_button_return_to_index.dart';
import '../fixedDatas/variables.dart';

class GuestNumberForm extends StatefulWidget {
  const GuestNumberForm({super.key, required this.guestNumber, required this.loginStatus,});
  final int guestNumber;
  final int loginStatus;

  @override
  State<GuestNumberForm> createState() => _GuestNumberFormState();
}

class _GuestNumberFormState extends State<GuestNumberForm> {
  final int currentScreenId = guestNumberFormId;

  @override
  Widget build(BuildContext context) {
    String guestNumber = widget.guestNumber.toString();

    return Scaffold(
      appBar: Header(
        loginStatus: widget.loginStatus,
        guestNumber: widget.guestNumber,
        currentScreenId: currentScreenId,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '朝食の残り人数',
              style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.black,
                decoration: TextDecoration.none
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 70.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                        decoration: InputDecoration(
                          hintText: (widget.guestNumber).toString(),
                          hintStyle: TextStyle(fontSize: 30),
                        ),
                        onChanged: (val) {
                          guestNumber = val;
                        },
                      ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '名',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SaveButton(loginStatus: widget.loginStatus, guestNumber: int.parse(guestNumber)),
          ],
        ),
      ),
    );
  }
}
