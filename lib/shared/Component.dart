import 'package:flutter/material.dart';

void navigateToAndPush(BuildContext context , Widget widget ) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


void navigateAndRemove(BuildContext context , Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> widget), (route)=>false);
}

Text buildText(BuildContext context, {required String text}) => Text(
  text,
  style: Theme.of(context).textTheme.titleLarge,
);


MaterialColor getCurrentThemeColor({required String? condition}) {
  if (condition == null) {
    return Colors.blueGrey;
  }

  switch (condition) {
    case "Sunny":
    case "Clear":
      return Colors.amber;

    case "Partly cloudy":
    case "Overcast":
    case "Cloudy":
      return Colors.blueGrey;

    case "Mist":
      return Colors.cyan;

    case "Patchy rain possible":
    case "Rainy":
      return Colors.blue;

    case "Patchy snow possible":
    case "Snow":
      return Colors.indigo;

    case "Patchy sleet possible":
    case "Patchy freezing drizzle possible":
      return Colors.teal;

    case "Thundery outbreaks possible":
    case "Thunderstorm":
      return Colors.deepPurple;

    default:
      return Colors.blue;
  }
}
