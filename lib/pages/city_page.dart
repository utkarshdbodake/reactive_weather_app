import 'package:flutter/material.dart';

import './../bloc/weather_bloc.dart';
import './../provider/weather_provider.dart';

class CityPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = WeatherProvider.of(context);

    return Scaffold(
        appBar: AppBar(
            title: Text('City'),
            centerTitle: true,
            backgroundColor: Colors.red),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      onChanged: (text) => weatherBloc.cityText.add(text),
                      decoration: InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'Enter city',
                          hintText: 'City name')),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                      onPressed: () {
                        weatherBloc.submitCityButtonPressed.add(null);
                        Navigator.of(context).pop();
                      },
                      elevation: 4.0,
                      color: Colors.red.shade400,
                      child: Text(
                        'Change city',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ))
                ],
              ),
            ))

    );
  }
}
