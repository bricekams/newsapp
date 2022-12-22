import 'package:flutter/material.dart';
import 'package:newsapp/data/api/api.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/localization.dart';

class CategoryChip extends StatelessWidget {
  final int index;

  const CategoryChip({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    String label = categories[lang]![index];

    return GestureDetector(
      onTap: () {
        Provider.of<NewsAPI>(context, listen: false).setCategoryIndex = index;
      },
      child: Chip(
        backgroundColor:
            Provider.of<NewsAPI>(context, listen: true).currentCategoryIndex ==
                    index
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
        label: Row(
          children: [
            Text(
              "${label[0].toUpperCase()}${label.substring(1)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Provider.of<NewsAPI>(context, listen: true)
                              .currentCategoryIndex ==
                          index
                      ? Colors.white
                      : SettingsPrefs.darkMode?Theme.of(context).scaffoldBackgroundColor:null),
            ),

            /// if current chip and request loading
            if (Provider.of<NewsAPI>(context, listen: true)
                        .currentCategoryIndex ==
                    index &&
                Provider.of<NewsAPI>(context, listen: true)
                    .apiRequestStatus
                    .isLoading &&
                Provider.of<NewsAPI>(context, listen: true).articles.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
