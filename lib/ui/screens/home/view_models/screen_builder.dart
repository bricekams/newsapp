import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:newsapp/data/api/api.dart';
import 'package:newsapp/ui/screens/home/components/errors_widgets/api_error_widget.dart';
import 'package:newsapp/ui/screens/home/components/loading_widget/loading_widget.dart';
import 'package:newsapp/ui/screens/home/view_models/feeds_builder.dart';
import 'package:newsapp/ui/screens/home/view_models/headline_builder.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:provider/provider.dart';
import 'categories_builder.dart';

class ScreenBuilder extends StatefulWidget {
  const ScreenBuilder({Key? key}) : super(key: key);

  @override
  State<ScreenBuilder> createState() => _ScreenBuilderState();
}

class _ScreenBuilderState extends State<ScreenBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Provider.of<NewsAPI>(context, listen: false).articles.isEmpty) {
        Provider.of<NewsAPI>(context, listen: false).fetchNewsCategory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: [
        const CategoriesListBuilder(),
        _bodyBuilder(
            Provider.of<NewsAPI>(context, listen: true).apiRequestStatus),
      ],
    );
  }

  Widget _bodyBuilder(APIRequestStatus status) {
    if (status.isUninitialized) {
      return const ApiErrorWidget();
    }
    if (status.isLoading &&
        Provider.of<NewsAPI>(context, listen: false).articles.isEmpty) {
      return const LoadingWidget();
    }
    if (status.isLoaded) {
      return const Home();
    }
    if (status.hasError) {
      return const ApiErrorWidget();
    }
    if (status.hasConnectionError){
      return const ApiErrorWidget();
    }
    return const Home();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: const [HeadlineBuilder(), FeedsBuilder()],
    );
  }
}
