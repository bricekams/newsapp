import 'package:flutter/material.dart';

class NoInternetErrorWidget extends StatelessWidget {
  const NoInternetErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Internet"),
    );
  }
}
