import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/weather_area.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';
import '../fixedDatas/datas.dart';
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
  final int currentScreenId = itemIndexId;
  String _selectedCategoryValue = 'appetizer';

  var items = itemsArray;

  // カテゴリーソートはflutter連携時にやると良さそうなので、保留
  // List<Map<String, Object>> getItems() {
  //   if (_selectedCategoryValue == appetizerLabel) {
  //     items = items.where('category', isEqualTo: appetizerLabel) as List<Map<String, Object>>;
  //   } else if (_selectedCategoryValue == mainDishLabel) {
  //     items = items.where('category', isEqualTo: mainDishLabel);
  //   } else if (_selectedCategoryValue == beverageLabel) {
  //     items = items.where('category', isEqualTo: beverageLabel);
  //   }
  //
  //   return items;
  // }

  @override
  void initState() {
    super.initState();
    _selectedCategoryValue = categories[0];
  }

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
          DropdownButton(
            items: categories
                .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category)
            )).toList(),
            value: _selectedCategoryValue,
            onChanged: (value) => {
              setState(() {
                _selectedCategoryValue = value!;
              }),
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 60,
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
