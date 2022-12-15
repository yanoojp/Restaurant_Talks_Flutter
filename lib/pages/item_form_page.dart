import 'package:flutter/material.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({super.key, required this.title, this.itemObject});
  final String title;
  final itemObject;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {

  @override
  Widget build(BuildContext context) {
    String itemName = widget.itemObject != null ? "${widget.itemObject['itemName']}" : '';
    String itemStock = widget.itemObject != null ? "${widget.itemObject['itemStock']}" : '0';
    String itemDetail = widget.itemObject != null ? "${widget.itemObject['itemDetail']}" : '';

    return Scaffold(
        appBar: AppBar(
         title: Text(widget.title),
        ),
        body: Column(
          children: [
            TextField(
              controller: TextEditingController(
                  text: itemName,
              ),
              onChanged: (value) {
                itemName = value;
              },
            ),
            TextField(
              controller: TextEditingController(
                  text: itemStock,
              ),
              onChanged: (value) {
                itemStock = value;
              },
            ),
            TextField(
              controller: TextEditingController(
                  text: itemDetail,
              ),
              onChanged: (value) {
                itemDetail = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                print("保存ボタンが押されました");
                print(itemName);
                print(itemStock);
                print(itemDetail);
              },
              child: Text('保存する'),
            ),
          ],
        ),
    );
  }
}
