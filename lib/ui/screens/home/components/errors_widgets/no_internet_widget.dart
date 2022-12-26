import 'package:flutter/material.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';

import '../../../../../data/api/api.dart';

class NoInternetErrorWidget extends StatelessWidget {
  const NoInternetErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.network_check_rounded,size: 80,color: SettingsPrefs.darkMode?Colors.grey.shade300:Colors.grey.shade800),
          const SizedBox(height: 20),
          Text(
            dictionary["@internetError"][lang],
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: SettingsPrefs.darkMode?Colors.grey.shade300:Colors.grey.shade800),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade300),
            ),
            onPressed: (){
              Provider.of<NewsAPI>(context, listen: false).articles.clear();
              Provider.of<NewsAPI>(context, listen: false).fetchNewsCategory();
            },
            child: Text(
              dictionary['@tryAgain'][lang],
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey.shade700),
            ),
          )
        ],
      ),
    );
  }
}

Widget _boxImg() {
  return Container();
}

class BoxImg extends StatelessWidget {
  const BoxImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

