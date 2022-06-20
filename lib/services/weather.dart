import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '2ee1e46be86fd7a668fe7c5a32a2995a';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  double? latitude;
  double? longitude;

  Future<dynamic> getNewCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.parse(
          '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'),
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    LocationService locationService = LocationService();
    await locationService.confirmPermission();
    await locationService.getCurrentLocation();

    latitude = locationService.latitude;
    longitude = locationService.longitude;
    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.parse(
          '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
