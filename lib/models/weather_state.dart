import './../constants/constants.dart' as constants;

class WeatherState {
  final String city;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final double humidity;
  final bool isValidCity; // when false denotes that the city is not present in weather DB.
  final bool isLoading;

  WeatherState(
      {this.city,
      this.temperature,
      this.temperatureMin,
      this.temperatureMax,
      this.humidity,
      this.isValidCity = true,
      this.isLoading = false
      });

  WeatherState.initial()
      : city = constants.defaultCity,
        temperature = null,
        temperatureMin = null,
        temperatureMax = null,
        humidity = null,
        isValidCity = true,
        this.isLoading = true;

  WeatherState.loading()
      : city = constants.defaultCity,
        temperature = null,
        temperatureMin = null,
        temperatureMax = null,
        humidity = null,
        isValidCity = true,
        this.isLoading = true;

  @override
  String toString() => '''
    WeatherState {
      city: $city,
      temperature: $temperature,
      temperatureMin: $temperatureMin,
      temperatureMax: $temperatureMax,
      humidity: $humidity,
      isCityValid: $isValidCity,
      isLoading: $isLoading
    }
  ''';
}
