import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/components/save_button_return_to_index.dart';
import '../components/header.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../fixedDatas/variables.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({
    super.key,
    required this.title,
    this.itemObject,
    required this.loginStatus,
    required this.guestNumber
  });

  final String title;
  final int loginStatus;
  final int guestNumber;
  final itemObject;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  int _counter = 0;
  final int currentScreenId = itemFormPageId;

  final ImagePicker _picker = ImagePicker();
  File? _file;

  @override
  Widget build(BuildContext context) {
    String itemName =
      widget.itemObject != null ? "${widget.itemObject['itemName']}" : '';
    String itemStock =
      widget.itemObject != null ? "${widget.itemObject['itemStock']}" : '0';
    String itemDetail =
      widget.itemObject != null ? "${widget.itemObject['itemDetail']}" : '';
    String itemImage =
      widget.itemObject != null ? "${widget.itemObject['itemImage']}" : '';

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
          guestNumber: widget.guestNumber!,
          currentScreenId: currentScreenId,
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
                  controller: TextEditingController(
                      text: itemName,
                  ),
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
                          onPressed: decrementCounter,
                          tooltip: 'Decrement',
                          child: const Icon(Icons.remove),
                        ),
                        Text(
                            (_counter + int.parse(itemStock)).toString(),
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
                Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  width: double.infinity,
                  child: const Text(
                    itemDetailLabel,
                    textAlign: TextAlign.left,
                  ),
                ),
                TextField(
                  controller: TextEditingController(
                      text: itemDetail,
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: OutlinedButton(
                      onPressed: () async {
                        final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                        _file = File(image!.path);
                        setState(() {});
                      },
                      child: const Text('画像を選択')
                  ),
                ),
                //画像表示エリア
                if (_file != null && itemImage == '')
                  Image.file(_file!, fit: BoxFit.cover,)
                else if (itemImage != '')
                  Image.network(itemImage),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SaveButton(loginStatus: widget.loginStatus, guestNumber: widget.guestNumber,),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
