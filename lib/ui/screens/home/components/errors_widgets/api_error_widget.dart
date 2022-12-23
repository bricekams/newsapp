import 'package:flutter/material.dart';


///TODO: style text dark and light mode and action on press button

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,size: 80),
            const SizedBox(height: 20),
            Text(
              "An error occurred, it's not your fault",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade300),
              ),
              onPressed: (){},
              child: Text(
                  "Try again",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey.shade700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
