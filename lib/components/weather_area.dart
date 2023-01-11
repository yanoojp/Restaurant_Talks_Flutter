import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../fixedDatas/api_keys.dart';
import '../fixedDatas/variables.dart';

class WeatherArea extends StatefulWidget {
  const WeatherArea({super.key, required this.prefectureName});
  final String prefectureName;

  @override
  State<WeatherArea> createState() => _WeatherAreaState();
}

class _WeatherAreaState extends State<WeatherArea> {
  late String cityName;
  WeatherFactory wf =
      WeatherFactory(weatherApiKey, language: Language.JAPANESE);
  String currentWeather = '';
  late Future<String> cw;

  Future<String> getCurrentLocationWeather(String cityName) async {
    final w = await wf.currentWeatherByCityName(cityName);
    return w.weatherDescription!;
  }

  @override
  void initState() {
    super.initState();

    cityName = widget.prefectureName;
    cw = getCurrentLocationWeather(cityName);
    cw.then((value) => {
          currentWeather = value,
        },);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15),
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder(
            future: cw,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // アイコンの表示はTodo
                return Text(
                  '$weatherOutside：$currentWeather',
                );
              }
              return const Text('$weatherOutside：$gettingData');
            },),
      ),
    );
  }
}
