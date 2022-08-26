import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
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
          'Something went wrong',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
