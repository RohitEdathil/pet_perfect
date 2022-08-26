import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlaceholderLoading extends StatelessWidget {
  const PlaceholderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const PlaceholderLoadingMini());
  }
}

class PlaceholderLoadingMini extends StatelessWidget {
  const PlaceholderLoadingMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: LottieBuilder.asset('assets/loading.json'),
    );
  }
}
