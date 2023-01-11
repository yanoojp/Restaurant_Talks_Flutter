import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_talks_flutter/model/account.dart';
import '../components/header.dart';
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
        widget.itemObject != null ? "${widget.itemObject['itemName']}" : '';
    itemCount =
        widget.itemObject != null ? "${widget.itemObject['itemCount']}" : '0';
    itemDetail =
        widget.itemObject != null ? "${widget.itemObject['itemDetail']}" : '';
    category = widget.itemObject != null
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
    _itemNameController = TextEditingController(text: itemName);
    _itemDetailController = TextEditingController(text: itemDetail);

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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
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
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
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
                        heroTag: 'btn1',
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
                        heroTag: 'btn2',
                        onPressed: incrementCounter,
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: const Text(
                    categoryLabel,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
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
                padding: const EdgeInsets.only(top: 30),
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
                padding: const EdgeInsets.only(top: 30),
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      final editItem = {
                        'accountId': widget.loginUserInfo.id,
                        'itemName': _itemNameController.text,
                        'itemDetail': _itemDetailController.text,
                        'category': category,
                        'itemCount':
                            (_counter + int.parse(itemCount)).toString(),
                        'updatedAt': Timestamp.fromDate(DateTime.now()),
                      };

                      if (widget.currentScreenId == itemNewCreatePageId) {
                        final result = await ItemFirestore.setItem(editItem);
                        if (result == true) {
                          setState(_itemNameController.clear);
                          setState(_itemDetailController.clear);
                        } else {
                          //  TBD
                        }
                      } else {
                        final result = await ItemFirestore.updateItem(
                            editItem, widget.itemUserDocId!,);
                        if (result == true) {
                          setState(_itemNameController.clear);
                          setState(_itemDetailController.clear);
                        } else {
                          //  TBD
                        }
                      }

                      // 保存ボタン押下時の画面遷移
                      await Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: ItemIndex(
                                loginStatus: widget.loginStatus,
                              ),),);
                    },
                    child: const Text(saveButton),
                  ),),
              widget.currentScreenId == itemEditPageId
                  ? TextButton(
                      onPressed: () {
                        ItemFirestore.deleteItem(widget.itemUserDocId!);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: ItemIndex(
                                  loginStatus: widget.loginStatus,
                                ),),);
                      },
                      child: const Text(deleteItem),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
