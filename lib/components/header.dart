import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/utils/authentication.dart';
import 'package:restaurant_talks_flutter/utils/firestore/guestNumber.dart';
import '../fixedDatas/variables.dart';
import 'package:page_transition/page_transition.dart';
import '../model/account.dart';
import '../pages/guest_number_form.dart';
import '../pages/item_index.dart';
import '../pages/login_page.dart';

class Header extends StatefulWidget implements PreferredSizeWidget{
  const Header({
    super.key,
    required this.loginStatus,
    required this.currentScreenId
  });

  final int loginStatus;
  final int currentScreenId;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late int guestNumber;
  late Future<int> gn;
  Account myAccount = Authentication.myAccount!;

  @override
  void initState() {
    super.initState();

    gn = GuestNumberFirestore.getGuestNumber(myAccount.id);
    gn.then((value) => {
        guestNumber = value,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
        widget.currentScreenId == itemNewCreatePageId
            || widget.currentScreenId == itemEditPageId
            || widget.currentScreenId == guestNumberFormId
          ? IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: ItemIndex(
                          loginStatus: widget.loginStatus,
                        )
                    )
                );
              },
              icon: const Icon(Icons.arrow_back)
            )
          : const SizedBox.shrink(),
      title: Text(appTitle),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 15.0),
          child: FutureBuilder<int>(
            future: gn,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: () {
                    if (widget.currentScreenId != guestNumberFormId) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            GuestNumberForm(
                                guestNumber: guestNumber,
                                loginStatus: widget.loginStatus
                            )
                        ),
                      );
                    }
                  },
                  child: Text(
                    '$leftNumber:\n$guestNumber$peopleUnit'.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Text(
                  '$leftNumber:\n$gettingData',
                  textAlign: TextAlign.center,
                );
              }
            }
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => {
            Authentication.logout(),
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: LoginPage(),
                isIos: true,
              )
            ),
          },
        ),
      ],
    );
  }
}
