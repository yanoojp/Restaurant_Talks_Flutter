import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_talks_flutter/model/account.dart';
import '../components/header.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../fixedDatas/datas.dart';
import '../fixedDatas/variables.dart';
import '../utils/firestore/items.dart';
import 'item_index.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({
    super.key,
    this.itemObject,
    required this.loginStatus,
    required this.loginUserInfo,
    required this.currentScreenId,
    this.itemUserDocId,
  });

  final int loginStatus;
  final itemObject;
  final Account loginUserInfo;
  final int currentScreenId;
  final String? itemUserDocId;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  int _counter = 0;

  late String itemName;
  late String itemCount;
  late String itemDetail;
  late String category;

  @override
  void initState() {
    super.initState();

    itemName =
      widget.itemObject != null
        ? "${widget.itemObject['itemName']}"
        : '';
    itemCount =
      widget.itemObject != null
        ? "${widget.itemObject['itemCount']}"
        : '0';
    itemDetail =
      widget.itemObject != null
        ? "${widget.itemObject['itemDetail']}"
        : '';
    category =
      widget.itemObject != null
        ? "${widget.itemObject['category']}"
        : categoriesDropdown[0].value!;
  }

  // final ImagePicker _picker = ImagePicker();
  // File? _file;

  late TextEditingController _itemNameController;
  late TextEditingController _itemDetailController;

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _itemNameController = TextEditingController(
        text: itemName
    );
    _itemDetailController = TextEditingController(
        text: itemDetail
    );

    void incrementCounter() {
      setState(() {
        _counter++;
      });
    }

    void decrementCounter() {
      setState(() {
        _counter--;
      });
    }

    return Scaffold(
        appBar: Header(
          loginStatus: widget.loginStatus,
          currentScreenId: widget.currentScreenId,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: const Text(
                    itemNameLabel,
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: _itemNameController,
                  onChanged: (value) {
                    itemName = value;
                  },
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
                      width: double.infinity,
                      child: const Text(
                        itemStockLabel,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: () {
                            if (_counter + int.parse(itemCount) > 0) {
                              decrementCounter();
                            }
                          },
                          tooltip: 'Decrement',
                          child: const Icon(Icons.remove),
                        ),
                        Text(
                          (_counter + int.parse(itemCount)).toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: incrementCounter,
                          tooltip: 'Increment',
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    width: double.infinity,
                    child: const Text(
                      categoryLabel,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    items: categoriesDropdown,
                    value: category,
                    onChanged: (value) => {
                      setState(() {
                        category = value!;
                      }),
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  width: double.infinity,
                  child: const Text(
                    itemDetailLabel,
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: _itemDetailController,
                  onChanged: (value) {
                    itemDetail = value;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  width: double.infinity,
                  child: const Text(
                    itemImageLabel,
                    textAlign: TextAlign.left,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                //   child: OutlinedButton(
                //       onPressed: () async {
                //         final XFile? image =
                //           await _picker.pickImage(source: ImageSource.gallery);
                //         _file = File(image!.path);
                //         setState(() {});
                //       },
                //       child: const Text(pickAImage)
                //   ),
                // ),

                // //画像表示エリア
                // if (_file != null && itemImage == '')
                //   Image.file(_file!, fit: BoxFit.cover,)
                // else if (itemImage != '')
                //   Image.network(itemImage),

                // 保存ボタンエリア
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () async{

                      final editItem = {
                        'accountId': widget.loginUserInfo.id,
                        'itemName': _itemNameController.text,
                        'itemDetail': _itemDetailController.text,
                        'category': category,
                        'itemCount': (_counter + int.parse(itemCount)).toString(),
                        'updatedAt': Timestamp.fromDate(DateTime.now()),
                      };

                      if (widget.currentScreenId == itemNewCreatePageId) {
                        var _result = await ItemFirestore.setItem(editItem);
                        if (_result == true) {
                          setState(_itemNameController.clear);
                          setState(_itemDetailController.clear);
                        } else {
                        //  TBD
                        }
                      } else {
                        var _result = await ItemFirestore.updateItem(editItem, widget.itemUserDocId);
                        if (_result == true) {
                          setState(_itemNameController.clear);
                          setState(_itemDetailController.clear);
                        } else {
                          //  TBD
                        }
                      }

                      // 保存ボタン押下時の画面遷移
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
                    child: Text(saveButton),
                  )
                ),
                widget.currentScreenId == itemEditPageId
                  ? TextButton(
                      onPressed: () {
                        ItemFirestore.deleteItem(widget.itemUserDocId);
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
                      child: Text(deleteItem),
                    )
                  : const SizedBox.shrink()
              ],
            ),
          ),
        ),
    );
  }
}
