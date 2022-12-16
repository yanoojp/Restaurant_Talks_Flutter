import 'package:flutter/material.dart';
import 'item_index.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({super.key, required this.title, this.itemObject});
  final String title;
  final itemObject;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    String itemName = widget.itemObject != null ? "${widget.itemObject['itemName']}" : '';
    String itemStock = widget.itemObject != null ? "${widget.itemObject['itemStock']}" : '0';
    String itemDetail = widget.itemObject != null ? "${widget.itemObject['itemDetail']}" : '';

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
              ElevatedButton(
                onPressed: () {
                  print("保存ボタンが押されました");
                  print(itemName);
                  print(itemStock);
                  print(itemDetail);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemIndex()),
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
