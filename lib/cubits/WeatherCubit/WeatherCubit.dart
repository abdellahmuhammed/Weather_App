import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherState.dart';
import 'package:weather_app/model/weatherModel.dart';
import 'package:weather_app/weatherServices/weatherServices.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;

  getCurrentWeather({required String cityName}) async {
    try {
      emit(WeatherISLoadingState());
      weatherModel =
          await WeatherServices().getCurrentWeather(cityName: cityName);
      debugPrint('fetch data successfully');
      debugPrint(weatherModel!.cityName);
      emit(WeatherLoadedState());
    } on Exception catch (error) {
      print(
          'An error happened when creating Cubit and error is ${error.toString()}');
      emit(WeatherFiledState(error: error.toString()));
    }
  }
}
