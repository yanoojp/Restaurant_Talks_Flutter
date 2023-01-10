import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/weather_area.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import '../components/header.dart';
import '../components/bottom_navigation.dart';
import '../fixedDatas/datas.dart';
import '../model/account.dart';
import '../utils/authentication.dart';
import 'item_form_page.dart';

class ItemIndex extends StatefulWidget {
  const ItemIndex({
    super.key,
    required this.loginStatus,
  });

  final int loginStatus;

  @override
  State<ItemIndex> createState() => _ItemIndexState();
}

class _ItemIndexState extends State<ItemIndex> {
  final int currentScreenId = itemIndexId;
  late String _selectedCategoryValue;

  Account myAccount = Authentication.myAccount!;

  @override
  void initState() {
    super.initState();
    _selectedCategoryValue = categoriesDropdown[0].value!;
  }

  // var items = itemsArray;

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

  // item一覧のList作成
  List<Widget> getList(itemObjectList, snapshot) {
    List<Widget> listViewChildren = [];

    for (int i = 0; i < itemObjectList.length; i++) {
      listViewChildren.add(
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(100, 80)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ItemFormPage(
                        itemObject: itemObjectList[i],
                        loginStatus: widget.loginStatus!,
                        loginUserInfo: myAccount,
                        currentScreenId: itemEditPageId,
                        itemUserDocId: snapshot.data.docs[i].id,
                      )
                  ),
                );
              },
              child: Text(itemObjectList[i]['itemName']),
            ),
          )
      );
    }

    return listViewChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          loginStatus: widget.loginStatus,
          currentScreenId: currentScreenId,
      ),
      body: Column(
        children: [
          DropdownButton(
            items: categoriesDropdown,
            value: _selectedCategoryValue,
            onChanged: (value) => {
              setState(() {
                _selectedCategoryValue = value!;
              }),
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height / 100 * 60,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(

              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                // .collection('Users')
                    .collection(itemCollection)
                    .where("accountId", isEqualTo: myAccount.id)
                // .doc(myAccount.id)
                    .orderBy('updatedAt')
                    .snapshots(),

                builder: (context, snapshot) {

                  if (snapshot.hasError) {
                    return const Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items = snapshot.requireData.docs
                      .map((DocumentSnapshot document) {
                    final documentData =
                    document.data()!;
                    return documentData!;
                  }).toList();

                  final itemObjectList = items.reversed.toList();

                  // 一覧の表示
                  if (itemObjectList.isNotEmpty) {
                    return Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: getList(itemObjectList, snapshot),
                      );
                  }

                  // データがない場合
                  return const Text(
                    noDataMessage,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ),
          WeatherArea(prefectureName: myAccount.prefecture),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder:
                (context) => ItemFormPage(
                  loginStatus: widget.loginStatus,
                  loginUserInfo: myAccount,
                  currentScreenId: itemNewCreatePageId,
                )
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
        screenId: currentScreenId,
        loginStatus: widget.loginStatus,
        currentScreenId: currentScreenId,
      ),
    );
  }
}