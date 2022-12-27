import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/weather_area.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import '../components/Header.dart';
import '../components/bottom_navigation.dart';
import '../fixedDatas/datas.dart';
import '../fixedDatas/fixed_expressions.dart';
import 'item_form_page.dart';

class ItemIndex extends StatefulWidget {
  const ItemIndex({
    super.key,
    required this.loginStatus,
    required this.prefectureName,
    required this.guestNumber
  });

  final int loginStatus;
  final String prefectureName;
  final int guestNumber;

  @override
  State<ItemIndex> createState() => _ItemIndexState();
}

class _ItemIndexState extends State<ItemIndex> {
  final int currentScreenId = itemIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          loginStatus: widget.loginStatus,
          guestNumber: widget.guestNumber,
          currentScreenId: currentScreenId,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 66,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < items.length; i++) ... {
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: Size(100, 80)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ItemFormPage(
                                    title: title,
                                    itemObject: items[i],
                                    loginStatus: widget.loginStatus!,
                                    guestNumber: widget.guestNumber,
                                  )),
                            );
                            print("${items[i]['itemName']}が押されました");
                          },
                          child: Text("${items[i]['itemName']}"),
                        ),
                      }
                    ],
                  ),
                ),
              ),
            ),
          ),
          WeatherArea(prefectureName: widget.prefectureName),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder:
                (context) => ItemFormPage(
                  title: title,
                  loginStatus: widget.loginStatus,
                  guestNumber: widget.guestNumber,)
            ),
          );
          print("新規追加ボタンが押されました");
        },
      ),
      bottomNavigationBar: BottomNavigation(
        screenId: currentScreenId,
        loginStatus: widget.loginStatus,
        guestNumber: widget.guestNumber,
      ),
    );
  }
}
