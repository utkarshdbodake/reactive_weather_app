import 'package:flutter/widgets.dart';

import './../bloc/weather_bloc.dart';

class WeatherProvider extends InheritedWidget {
  final WeatherBloc searchBloc;

  WeatherProvider({Key key, WeatherBloc searchBloc, @required Widget child})
      : this.searchBloc = searchBloc ?? WeatherBloc(),
        super(key: key, child: child);

  static WeatherBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WeatherProvider)
            as WeatherProvider)
        .searchBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
