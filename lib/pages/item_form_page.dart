import 'package:flutter/material.dart';
import 'item_index.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({super.key, required this.title, this.itemObject, required this.loginStatus});
  final String title;
  final int loginStatus;
  final itemObject;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  int _counter = 0;

  final ImagePicker _picker = ImagePicker();
  File? _file;

  @override
  Widget build(BuildContext context) {
    String itemName = widget.itemObject != null ? "${widget.itemObject['itemName']}" : '';
    String itemStock = widget.itemObject != null ? "${widget.itemObject['itemStock']}" : '0';
    String itemDetail = widget.itemObject != null ? "${widget.itemObject['itemDetail']}" : '';
    String itemImage = widget.itemObject != null ? "${widget.itemObject['itemImage']}" : '';

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
        appBar: AppBar(
         title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(
                    text: itemName,
                ),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: decrementCounter,
                      tooltip: 'Decrement',
                      child: Icon(Icons.remove),
                    ),
                    Text(
                        (_counter + int.parse(itemStock)).toString(),
                        style: Theme.of(context).textTheme.headline4,
                    ),
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: incrementCounter,
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                  ],
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
              OutlinedButton(
                  onPressed: () async {
                    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
                    _file = File(_image!.path);
                    setState(() {});
                  },
                  child: const Text('画像を選択')
              ),
              //画像表示エリア
              if (_file != null && itemImage == '') Image.file(_file!, fit: BoxFit.cover,)
              else if (itemImage != '') Image.network(itemImage),
              ElevatedButton(
                onPressed: () {
                  print("保存ボタンが押されました");
                  print(itemName);
                  print(itemStock);
                  print(itemDetail);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemIndex(loginStatus: widget.loginStatus,)),
                  );
                },
                child: Text('保存する'),
              ),
            ],
          ),
        ),
    );
  }
}
