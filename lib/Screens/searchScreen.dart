// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Screens/HomeScreen.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherCubit.dart';
import 'package:weather_app/shared/Component.dart';
import 'package:weather_app/shared/constant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'There is no weather now 😔  please  start searching now 🔍',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/search.png',
                    height: 300,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter City Name',
                    suffixIcon: Icon(Icons.search),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        cityController.text.isEmpty || value.trim().isEmpty) {
                      return 'Please Enter City name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (cityName) async {
                    if (formKey.currentState!.validate()) {
                      try {
                        navigateAndRemove(context, HomeScreen());
                       
                        await BlocProvider.of<WeatherCubit>(context)
                            .getCurrentWeather(cityName: cityName);
                      } on Exception catch (e) {
                        print(e.toString());}
                    }
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: MaterialButton(
                    height: 40,
                    minWidth: double.infinity,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: kButtonColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        navigateAndRemove(context, HomeScreen());
                        await BlocProvider.of<WeatherCubit>(context)
                            .getCurrentWeather(cityName: cityController.text);
                      }
                    },
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*Future<String> _translateCityName({required String cityName}) async {
    final translator = GoogleTranslator();
    final translation =
        await translator.translate(cityName, from: 'ar', to: 'en');
    return translation.text;
  }*/
}
