import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 40,
        ),
        const SizedBox(height: 16, width: double.infinity),
        Text(
          'Error',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16, width: double.infinity),
        Text(
          'Please check your internet connection.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
