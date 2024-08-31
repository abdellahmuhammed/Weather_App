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