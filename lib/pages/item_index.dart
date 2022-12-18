import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/pages/login_page.dart';
import 'item_form_page.dart';

class ItemIndex extends StatefulWidget {
  const ItemIndex({super.key});

  @override
  State<ItemIndex> createState() => _ItemIndexState();
}

class _ItemIndexState extends State<ItemIndex> {
  final String title = 'Restaurant Talks Flutter';

  var items = [
    {
      'itemName': "サーモンマリネ",
      'itemStock': 1,
      'itemDetail': "サーモンマリネサーモンマリネサーモンマリネ",
      'itemImage': 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    },
    {
      'itemName': "タコのカルパッチョ",
      'itemStock': 2,
      'itemDetail': "タコのカルパッチョタコのカルパッチョタコのカルパッチョ",
      'itemImage': 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    },
    {
      'itemName': "スパニッシュオムレツ",
      'itemStock': 3,
      'itemDetail': "スパニッシュオムレツスパニッシュオムレツスパニッシュオムレツ",
      'itemImage': 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    String title = 'Restaurant Talks Flutter';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => {
                Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                print("ログアウトボタンが押されました")
             },
            ),
          ],
      ),
      body: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          for(int i = 0; i < items.length; i++) ... {
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(100, 80)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemFormPage(title: title, itemObject: items[i],)),
                );
                print("${items[i]['itemName']}が押されました");
              },
              child: Text("${items[i]['itemName']}"),
            ),
          }
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemFormPage(title: title)),
          );
          print("新規追加ボタンが押されました");
        },
      ),
    );
  }
}
