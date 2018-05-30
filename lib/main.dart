import 'package:flutter/material.dart';

import './pages/weather_page.dart';
import './provider/weather_provider.dart';

void main() => runApp(ReactiveWeatherApp());

class ReactiveWeatherApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return WeatherProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Reactive Weather',
            theme: ThemeData(
                fontFamily: 'Raleway',
                textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Colors.blue[700],
                    displayColor: Colors.blue[700])),
            home: WeatherPage()));
  }
}
