import 'dart:async';
import 'package:rxdart/rxdart.dart';

import './../constants/constants.dart' as constants;
import './../models/weather_state.dart';
import './../dao/weather_dao.dart';

class WeatherBloc {
  static String _city = constants.defaultCity;

  final BehaviorSubject<WeatherState> _weatherStateStream =
      BehaviorSubject<WeatherState>(seedValue: WeatherState.initial());
  final StreamController<String> _cityText = StreamController<String>();
  final StreamController _submitCityButtonPressed = StreamController();

  Stream<WeatherState> get weatherStateStream => _weatherStateStream;
  Sink<String> get cityText => _cityText;
  Sink get submitCityButtonPressed => _submitCityButtonPressed;

  WeatherBloc() {
    _cityText.stream.listen(_cityTextObserver);
    _submitCityButtonPressed.stream.listen(_submitCityButtonPressedObserver);
  }

  void _cityTextObserver(String text) => _city = text;

  void _submitCityButtonPressedObserver(_) async {
    Observable.fromFuture(WeatherDao.getClimateSummary(_city))
        .startWith(WeatherState.loading())
        .listen((WeatherState weatherState) {
          if (weatherState == null) return;
          _weatherStateStream.add(weatherState);
        });
  }

  void submitCityButtonPressedObserver(_) =>
      _submitCityButtonPressedObserver(_);

  void dispose() {
    _cityText.close();
    _weatherStateStream.close();
    _submitCityButtonPressed.close();
  }
}
