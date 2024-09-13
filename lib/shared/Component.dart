import 'package:flutter/material.dart';

void navigateToAndPush(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndRemove(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Text buildText(BuildContext context, {required String text}) => Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    );

MaterialColor getCurrentThemeColor({required String? condition}) {
  if (condition == null) {
    return Colors.blueGrey; // حالة افتراضية إذا كانت الحالة غير معروفة
  }

  switch (condition) {
    case "Sunny":
    case "Clear":
      return Colors.orange; // برتقالي يعكس الجو الحار والمشمس

    case "Partly cloudy":
    case "Overcast":
    case "Cloudy":
      return Colors.blueGrey; // أزرق رمادي يعكس الجو الغائم

    case "Mist":
      return Colors.grey; // رمادي يعكس الأجواء الضبابية

    case "Patchy rain possible":
    case "Rainy":
      return Colors.blue; // أزرق يعكس الأمطار

    case "Patchy snow possible":
    case "Snow":
      return Colors.lightBlue; // أزرق فاتح يعكس الثلوج والبرد

    case "Patchy sleet possible":
    case "Patchy freezing drizzle possible":
      return Colors.teal; // لون بارد يعكس الأمطار المتجمدة

    case "Thundery outbreaks possible":
    case "Thunderstorm":
      return Colors.deepPurple; // بنفسجي غامق يعكس العواصف

    default:
      return Colors.blue; // الأزرق للحالات الأخرى
  }
}
