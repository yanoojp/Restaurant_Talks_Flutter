import 'package:flutter/material.dart';
import 'package:restaurant_talks_flutter/fixedDatas/api_keys.dart';
import 'package:weather/weather.dart';
import '../components/Header.dart';
import '../components/bottom_navigation.dart';
import '../fixedDatas/datas.dart';
import '../fixedDatas/fixed_expressions.dart';
import 'item_form_page.dart';

class ItemIndex extends StatefulWidget {
  const ItemIndex({super.key, required this.loginStatus, required this.prefectureName, required this.guestNumber});
  final int loginStatus;
  final String prefectureName;
  final int guestNumber;

  @override
  State<ItemIndex> createState() => _ItemIndexState();
}

class _ItemIndexState extends State<ItemIndex> {

  /// ** 天気情報の取得 ** //
  late String cityName;
  WeatherFactory wf = WeatherFactory(weatherApiKey, language: Language.JAPANESE);
  String currentWeather = '';
  late Future<String> cw;

  Future<String> getCurrentLocationWeather(String cityName) async {
    Weather w = await wf.currentWeatherByCityName(cityName);
    return w.weatherDescription!;
  }
  /// ** 天気情報の取得 ** //

  @override
  void initState() {
    super.initState();

    // 天気のセット
    cityName = widget.prefectureName;
    cw = getCurrentLocationWeather(cityName);
    cw.then((value) => {
      currentWeather = value,
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Header(loginStatus: widget.loginStatus, guestNumber: widget.guestNumber),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height / 100 * 67,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                for(int i = 0; i < items.length; i++) ... {
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
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 15.0),
            child: Container(
              width: double.infinity,
              child: FutureBuilder(
                  future: cw,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // アイコンの表示はTodo
                      return Text(
                        '外の天気：$currentWeather',
                        style: const TextStyle(
                        ),
                      );
                    } else {
                      return const Text("'外の天気：データ取得中...");
                    }
                  }
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemFormPage(title: title, loginStatus: widget.loginStatus, guestNumber: widget.guestNumber,)),
          );
          print("新規追加ボタンが押されました");
        },
      ),
      bottomNavigationBar: BottomNavigation(screenId: 0, loginStatus: widget.loginStatus, guestNumber: widget.guestNumber,),
    );
  }
}
