// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Screens/searchScreen.dart';
import 'package:weather_app/Screens/weatherInfoBody.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherCubit.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherState.dart';
import 'package:weather_app/shared/constant.dart';
import 'package:weather_app/shared/Component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return const SearchScreen();
          } else if (state is WeatherISLoadingState) {
            return _buildLoadingState(context);
          } else if (state is WeatherLoadedState) {
            return const WeatherInfoBody();
          } else {
            return _buildErrorState(context);
          }
        },
      ),
    );
  }



  Widget _buildLoadingState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 15),
        Text(
          'Weather Data is Loading',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      navigateAndRemove(context, const SearchScreen());
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Oops! You entered the city name incorrectly or another error occurred. Please try again.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
