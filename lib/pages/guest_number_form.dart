import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../components/header.dart';
import '../fixedDatas/variables.dart';
import 'item_index.dart';

class GuestNumberForm extends StatefulWidget {
  const GuestNumberForm({super.key, required this.guestNumber, required this.loginStatus,});
  final int guestNumber;
  final int loginStatus;

  @override
  State<GuestNumberForm> createState() => _GuestNumberFormState();
}

class _GuestNumberFormState extends State<GuestNumberForm> {
  final int currentScreenId = guestNumberFormId;
  final TextEditingController guestNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int guestNumber = widget.guestNumber;

    return Scaffold(
      appBar: Header(
        loginStatus: widget.loginStatus,
        currentScreenId: currentScreenId,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              guestNumberLabel,
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
                          fontSize: titleFontSize + 30,
                        ),
                        decoration: InputDecoration(
                          hintText: (widget.guestNumber).toString(),
                          hintStyle: TextStyle(fontSize: 30),
                        ),
                        onChanged: (val) {
                          guestNumber = int.parse(val);
                        },
                      ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      peopleUnit,
                      style: TextStyle(
                        fontSize: titleFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final document = <String, dynamic>{
                  'guestNumber': guestNumberController.text,
                };
                FirebaseFirestore.instance
                    .collection('GuestNumber')
                    .doc()
                    .set(document);
                setState(guestNumberController.clear);

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: ItemIndex(
                            loginStatus: widget.loginStatus,
                            guestNumber: guestNumber
                        )
                    )
                );
              },
              child: Text(saveButton),
            ),
          ],
        ),
      ),
    );
  }
}
