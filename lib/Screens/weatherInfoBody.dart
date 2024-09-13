// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Screens/searchScreen.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherCubit.dart';
import 'package:weather_app/shared/Component.dart';
import 'package:intl/intl.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key});
  @override
  Widget build(BuildContext context) {
    var weatherCubit = BlocProvider.of<WeatherCubit>(context).weatherModel!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration:
                BoxDecoration(gradient: _buildLinearGradient(weatherCubit , color1: 300, color2: 300,color3: 100)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildLocationCity(context, weatherCubit),
                  _buildSizedBox(context),
                  _buildImage(context),
                  _buildSizedBox(context),
                  _buildWeatherContainer(
                    context,
                    weatherCubit,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Weather hourly for Today',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildHourlyWeatherList(context, weatherCubit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCity(BuildContext context, weatherCubit) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined),
        const SizedBox(width: 15),
        buildText(context, text: weatherCubit.cityName),
        buildText(context, text: ', ${weatherCubit.countryName}'),
        const Spacer(),
        IconButton(
          color: Colors.black,
          onPressed: () {
            navigateToAndPush(context,  SearchScreen());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  // to build image check temp and return image
  _buildImage(context, {double height = 100}) {
    var weatherCubit = BlocProvider.of<WeatherCubit>(context).weatherModel!;
    double temperature = weatherCubit.temp; // الحصول على درجة الحرارة

    // تحديد الصورة بناءً على درجة الحرارة
    String imagePath;

    if (temperature <= 0) {
      imagePath = 'assets/images/snow.png'; // ثلج
    } else if (temperature > 0 && temperature <= 10) {
      imagePath = 'assets/images/rain.png'; // مطر
    } else if (temperature > 10 && temperature <= 20) {
      imagePath = 'assets/images/thunderstorm.png'; // غيوم
    } else if (temperature > 20 && temperature <= 30) {
      imagePath = 'assets/images/cloudy.png'; // عواصف رعدية
    } else if (temperature > 30) {
      imagePath = 'assets/images/clear.png'; // صافٍ
    } else {
      return Container(); // في حالة لم تطابق أي شرط
    }
    return Image.asset(
      imagePath,
      height: height,
    );
  }


  Widget _buildWeatherContainer(BuildContext context, weatherCubit) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: _buildLinearGradient(weatherCubit,
            begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          buildText(
            context,
            text:
                'Updated Today at  ${DateFormat('h:m a').format(weatherCubit.date)}',
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .37,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                child: Text(
                  '${weatherCubit.temp.round()}°',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max Temp: ${weatherCubit.maxTemp.round()}°c',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Main Temp: ${weatherCubit.mainTemp.round()}°c',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Humidity: ${weatherCubit.humidity.round()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildText(context, text: weatherCubit.weatherState),
        ],
      ),
    );
  }

  LinearGradient _buildLinearGradient(weatherCubit,
      {Alignment begin = Alignment.topLeft,
      Alignment end = Alignment.bottomRight,
      int color1 = 200,
      color2 = 100,
      color3 = 50}) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        getCurrentThemeColor(condition: weatherCubit.weatherState)[color1]!,
        getCurrentThemeColor(condition: weatherCubit.weatherState)[color2]!,
        getCurrentThemeColor(condition: weatherCubit.weatherState)[color3]!,
      ],
    );
  }

  Widget _buildHourlyWeatherList(BuildContext context, weatherCubit) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .02,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: _buildLinearGradient(weatherCubit,color1: 400,
            begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          width: 15,
          color: Colors.transparent,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: weatherCubit.hourlyWeatherList.length,
        itemBuilder: (context, index) {
          final hourlyWeather = weatherCubit.hourlyWeatherList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                buildText(
                  context,
                  text: DateFormat('h:mm: a').format(hourlyWeather.time),
                ),
                const SizedBox(height: 10),
                _buildImage(context, height: 70),
                const SizedBox(height: 10),
                buildText(
                  context,
                  text: '${hourlyWeather.temp.round()}°c',
                ),
                const SizedBox(height: 10),
                buildText(
                  context,
                  text: hourlyWeather.weatherState,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSizedBox(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * .025,
      );
}
