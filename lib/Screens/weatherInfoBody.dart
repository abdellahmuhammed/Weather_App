// // ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Screens/searchScreen.dart';
import 'package:weather_app/cubits/WeatherCubit/WeatherCubit.dart';
import 'package:weather_app/shared/Component.dart';
import 'package:weather_app/shared/constant.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key });
  @override
  Widget build(BuildContext context) {
    var weatherCubit = BlocProvider.of<WeatherCubit>(context).weatherModel!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: getCurrentThemeColor(condition: '${weatherCubit.weatherState}'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 15),
                    Text(
                      weatherCubit.cityName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      ',${weatherCubit.countryName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    IconButton(
                        color: Colors.black,
                        onPressed: () {
                          navigateToAndPush(context, SearchScreen());
                        },
                        icon: Icon(Icons.search))
                  ],
                ),
                buildSizedBox(context),
                buildImage(context),
                buildSizedBox(context),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[200]!,
                        getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[100]!,
                        getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[50]!,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      buildText(context, text: '${weatherCubit.date}'),
                      const SizedBox(height: 15),
                      //buildDateAndTime(context),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .35,
                                right: MediaQuery.of(context).size.width * .06),
                            child: Text(
                              '${weatherCubit.temp.round()}°c',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 60),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Temp: ${weatherCubit.maxTemp.round()}°c ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                'Main Temp: ${weatherCubit.mainTemp.round()}°c ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                'Humidity: ${weatherCubit.humidity.round()}% ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      buildText(context, text: '${weatherCubit.weatherState}'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Text(
                  'Weather hourly for Today',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                // buildContainerHours(context),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .02,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[400]!,
                            getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[200]!,
                            getCurrentThemeColor(condition: '${weatherCubit.weatherState}')[50]!,
                          ],),),
                  child: ListView.builder(
                    itemCount: weatherCubit.hourlyWeatherList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            Text(
                              ('${weatherCubit.hourlyWeatherList[0].time}'),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Image.network(
                              'http:${weatherCubit.hourlyWeatherList[0].image}',
                              height: 50,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${weatherCubit.hourlyWeatherList[0].temp.round()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              weatherCubit.hourlyWeatherList[0].weatherState,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSizedBox(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * .025,
      );


  // to build image check temp and return image
  Widget buildImage(context) {
    var weatherCubit = BlocProvider.of<WeatherCubit>(context).weatherModel!;
    return weatherCubit.temp <= 0
        ? Image.asset('assets/images/snow.png')
        : weatherCubit.temp > 0 && weatherCubit.temp <= 10
        ? Image.asset('assets/images/rainy.png')
        : weatherCubit.temp > 10 && weatherCubit.temp <= 20
        ? Image.asset('assets/images/cloudy.png')
        : weatherCubit.temp > 20 && weatherCubit.temp <= 30
        ? Image.asset('assets/images/thunderstorm.png')
        : weatherCubit.temp > 30
        ? Image.asset('assets/images/clear.png')
        : Container();
  }



}


/*


FutureBuilder(
            future: WeatherServices().getCurrentWeather(cityName: cityName?.text ??'qena'),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapShot.hasData && snapShot.data != null) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 15),
                            Text(
                              weatherCubit!.cityName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              'Country Name',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(),
                            IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  navigateToAndPush(context, SearchScreen());
                                },
                                icon: Icon(Icons.search))
                          ],
                        ),
                        buildSizedBox(context),
                        Image.asset('assets/images/cloudy.png'),
                        buildSizedBox(context),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blueGrey[500]!,
                                Colors.blueGrey[200]!,
                                Colors.blueGrey[50]!,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              buildText(context, text: 'Weather Date'),
                              const SizedBox(height: 15),
                              //buildDateAndTime(context),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .06),
                                    child: Text(
                                      '17 ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Max Temp: 25°c ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        'Main Temp: 15°c ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        'Humidity: 25% ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              buildText(context, text: 'Weather State: Cloudy'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        Text(
                          'Weather hourly for Day',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 30),
                        // buildContainerHours(context),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .02,
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blueGrey[500]!,
                                    Colors.blueGrey[200]!,
                                    Colors.blueGrey[50]!,
                                  ])),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // const SizedBox(
                                    //   height: 30,
                                    // ),
                                    Text(
                                      ('hh:mm: a'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/rainy.png',
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'hourlyTemp',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'cloud',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapShot.hasError || snapShot.error == true) {
                return Text('Error happened');
              }
              return Text('some error happened');
            })


 */
