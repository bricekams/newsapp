import 'package:flutter/material.dart';

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("An Error Occurred"),
    );
  }
}
