import 'package:flutter/material.dart';
import 'package:weather_app/Screens/searchScreen.dart';
import 'package:weather_app/shared/Component.dart';
import 'package:weather_app/shared/constant.dart';

class NoWeatherBody extends StatelessWidget {
  const NoWeatherBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(onPressed: (){
            navigateToAndPush(context, SearchScreen());
          }, icon: Icon(Icons.search))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'there is no weather 😔 start pleas searching now 🔍',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                'searching now 🔍',
                style: TextStyle(
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}