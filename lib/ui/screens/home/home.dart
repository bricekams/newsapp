import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/components/search_delegate/search_delegate.dart';
import 'package:newsapp/ui/screens/home/view_models/categories_builder.dart';
import 'package:newsapp/ui/screens/home/view_models/screen_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewsApp"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ArticleSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: const CategoriesListBuilder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: SizedBox(
        height: 35,
        width: 35,
        child: FloatingActionButton(
          onPressed: (){
            if(scrollController.hasClients) scrollController.position.restoreOffset(0.0);
          },
          child: Icon(Icons.arrow_drop_up,color: Theme.of(context).scaffoldBackgroundColor,),
        ),
      ),
      body: const ScreenBuilder(),
    );
  }
}
