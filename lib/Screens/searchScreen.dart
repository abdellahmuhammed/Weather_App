// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Screens/HomeScreen.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherCubit.dart';
import 'package:weather_app/shared/Component.dart';
import 'package:weather_app/shared/constant.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();
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
                        cityController.text.isEmpty) {
                      return 'Please Enter City name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (cityName) async {
                    if (formKey.currentState!.validate()) {
                      navigateAndRemove(context, HomeScreen());
                      await BlocProvider.of<WeatherCubit>(context)
                          .getCurrentWeather(cityName: cityName);
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
                      // WeatherModel weatherModel = await WeatherServices()
                      //     .getCurrentWeather(cityName: cityController.text);
                      // print(weatherModel.cityName);
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

// Widget buildSearchScreen(
//   BuildContext context,
//   TextEditingController cityController,
//   GlobalKey<FormState> formKey,
// ) {
//   return Form(
//     key: formKey,
//     child: SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Please Search About City to show weather',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           Center(
//             child: Image.asset(
//               'assets/images/search.png',
//               height: 300,
//             ),
//           ),
//           const SizedBox(height: 20),
//           buildTextFormField(cityController, context, formKey),
//           const SizedBox(height: 80),
//           buildSearchButton(context, cityController, formKey),
//         ],
//       ),
//     ),
//   );
// }

// Widget buildTextFormField(TextEditingController cityController,
//     BuildContext context, GlobalKey<FormState> formKey) {
//   return TextFormField(
//     controller: cityController,
//     decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(20),
//         labelText: 'Enter City Name',
//         suffixIcon: Icon(Icons.search)),
//     onFieldSubmitted: (cityName) async {
//       WeatherServices().getCurrentWeather(cityName: cityName);
//     },
//     validator: (value) => buildValidate(value, cityController),
//   );
// }

// Future<String> translateCityName(String cityName) async {
//   final translator = GoogleTranslator();
//   final translation =
//   await translator.translate(cityName, from: 'ar', to: 'en');
//   return translation.text;
// }
/*
*
*
* */
// String? buildValidate(
//     String? cityName, TextEditingController cityController) {
//   if (cityName == null || cityName.isEmpty || cityController.text.isEmpty) {
//     return 'Please Enter City name';
//   }
//   return null;
// }
/*
*
*
* */
// AppBar buildAppBar(BuildContext context) {
//   return AppBar(
//     title: Text(
//       'Search City',
//       style: Theme.of(context).textTheme.titleLarge,
//     ),
//   );
// }
/**/
// Widget buildSearchButton(BuildContext context,
//     TextEditingController cityController, GlobalKey<FormState> formKey) {
//   return Center(
//     child: TextButton(
//       onPressed: () async {
//         if (formKey.currentState!.validate()) {
//           await WeatherServices().getCurrentWeather(cityName: 'cairo');
//         }
//       },
//       child: const Text('Search'),
//     ),
//   );
// }
}
