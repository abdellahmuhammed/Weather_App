// ignore_for_file: file_names

class WeatherModel {
  final String cityName;
  final String countryName;
  final DateTime date;
  final String image;
  final String weatherState;
  final double temp;
  final double maxTemp;
  final double mainTemp;
  final List<HourlyWeather> hourlyWeatherList;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.countryName,
    required this.date,
    required this.image,
    required this.weatherState,
    required this.temp,
    required this.maxTemp,
    required this.mainTemp,
    required this.hourlyWeatherList,
    required this.humidity
  });

  // Factory constructor to create a WeatherModel from JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> jsonData) {
    List<HourlyWeather> hourlyList =
    (jsonData['forecast']['forecastday'][0]['hour'] as List)
        .map((hourData) => HourlyWeather.fromJson(hourData))
        .toList();

    return WeatherModel(
      cityName: jsonData['location']['name'],
      countryName: jsonData['location']['country'],
      date: DateTime.parse(jsonData['current']['last_updated']),
      image: jsonData['forecast']['forecastday'][0]['day']['condition']['icon'],
      weatherState: jsonData['forecast']['forecastday'][0]['day']['condition']
      ['text'],
      temp: jsonData['forecast']['forecastday'][0]['day']['avgtemp_c'],
      maxTemp: jsonData['forecast']['forecastday'][0]['day']['maxtemp_c'],
      mainTemp: jsonData['forecast']['forecastday'][0]['day']['mintemp_c'],
      humidity:jsonData['current']['humidity'],
      hourlyWeatherList: hourlyList,
    );
  }
}

class HourlyWeather {
  final DateTime time;
  final double temp;
  final String image;
  final String weatherState;

  HourlyWeather({
    required this.time,
    required this.temp,
    required this.image,
    required this.weatherState,
  });

  // Factory constructor to create an HourlyWeather from JSON data
  factory HourlyWeather.fromJson(Map<String, dynamic> jsonData) {
    return HourlyWeather(
      time: DateTime.parse(jsonData['time']),
      temp: jsonData['temp_c'],
      image: jsonData['condition']['icon'],
      weatherState: jsonData['condition']['text'],
    );
  }
}
