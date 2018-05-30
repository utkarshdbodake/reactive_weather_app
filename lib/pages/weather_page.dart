import 'package:flutter/material.dart';

import './city_page.dart';
import './../models/weather_state.dart';
import './../bloc/weather_bloc.dart';
import './../provider/weather_provider.dart';

class WeatherPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = WeatherProvider.of(context);
    // We call below submitCityButtonPressedObserver so as to
    // load the initial weather of the default city.
    weatherBloc.submitCityButtonPressedObserver(null);

    return Scaffold(
        appBar: AppBar(
            title: Text('Reactive Weather'),
            centerTitle: true,
            backgroundColor: Colors.red,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _openCityPage(context);
                  })
            ]),
        body: Container(
            child: StreamBuilder(
                stream: weatherBloc.weatherStateStream,
                initialData: WeatherState.initial(),
                builder: (context, AsyncSnapshot<WeatherState> snapshot) {
                  return Stack(children: <Widget>[
                    Image.asset('images/weatherBackground.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                      child: Text(snapshot.data.city ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: snapshot.data.isLoading ? 0.0 : 1.0,
                          child: Image.asset('images/raining.png'),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  snapshot.data.temperature != null
                                      ? 'Average: ${snapshot.data.temperature.toString()} C'
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  snapshot.data.temperatureMin != null
                                      ? 'Min: ${snapshot.data.temperatureMin.toString()} C'
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  snapshot.data.temperatureMax != null
                                      ? 'Max: ${snapshot.data.temperatureMax.toString()} C'
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  snapshot.data.humidity != null
                                      ? 'Humidity: ${snapshot.data.humidity.toString()} %'
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500)),
                              Opacity(
                                  opacity:
                                      snapshot.data.isValidCity ? 0.0 : 1.0,
                                  child: Center(
                                    child: Text(
                                      'City not found in database!',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  )),
                            ])
                        ),
                    Container(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: snapshot.data.isLoading ? 1.0 : 0.0,
                          child: CircularProgressIndicator(),
                        )),
                  ]);
                })));
  }

  void _openCityPage(BuildContext context) {
    Route route = MaterialPageRoute(builder: (context) => CityPage());
    Navigator.of(context).push(route);
  }
}
