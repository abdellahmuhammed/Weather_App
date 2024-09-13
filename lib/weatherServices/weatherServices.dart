// ignore_for_file: file_names



import 'package:dio/dio.dart';
import 'package:weather_app/model/weatherModel.dart';

class WeatherServices {
  Dio dio = Dio();
  final String baseUrl = 'https://api.weatherapi.com/v1/forecast.json';
  final String apiKey = '3941c028ee974cb6a44144944241608';

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      // لو الكود شغال تمام يبقي نفذ الميثود دي
      Response response =
      await dio.get('$baseUrl?key=$apiKey&q=$cityName');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (error) {
      // لو في مشاكل من ال dio
      final String errorMessage = error.response?.data['error']['message'] ??
          'error in Web services pleas retry later';
      throw Exception(
          'Error happened while getting Api from Server And Error in : $errorMessage \n Error Exception : ${error.toString()}');
    } catch (error) {
      // لو في مشاكل اخري غير ال dio
      throw Exception(
          'oops There was an error pleas retry later ${error.toString()}');
    }
  }
}
