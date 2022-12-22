import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/components/search_delegate/search_delegate.dart';
import 'package:newsapp/ui/screens/home/view_models/screen_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewsApp"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ArticleSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: const ScreenBuilder(),
    );
  }
}
