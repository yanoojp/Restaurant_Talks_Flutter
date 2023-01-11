import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/weather_area.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';
import 'package:restaurant_talks_flutter/utils/firestore/items.dart';
import '../components/bottom_navigation.dart';
import '../components/header.dart';
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

  // item一覧のList作成
  List<Widget> getList(List<Object> itemObjectList, snapshot) {
    final listViewChildren = <Widget>[];

    for (var i = 0; i < itemObjectList.length; i++) {
      final itemObject =  itemObjectList[i] as Map;

      listViewChildren.add(Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 80)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemFormPage(
                        itemObject: itemObject,
                        loginStatus: widget.loginStatus,
                        loginUserInfo: myAccount,
                        currentScreenId: itemEditPageId,
                        itemUserDocId: snapshot.data.docs[i].id as String,
                      ),),
            );
          },
          child: Text(itemObject['itemName'] as String),
          // child: Text('itemName'),
        ),
      ),);
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

          // ソート用 Dropdown
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
            padding: const EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height / 100 * 60,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: ItemFirestore.getItem(myAccount.id, _selectedCategoryValue),
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
                    final documentData = document.data()!;
                    return documentData;
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
            MaterialPageRoute(
                builder: (context) => ItemFormPage(
                      loginStatus: widget.loginStatus,
                      loginUserInfo: myAccount,
                      currentScreenId: itemNewCreatePageId,
                    ),),
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
