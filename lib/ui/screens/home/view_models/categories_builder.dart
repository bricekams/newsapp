import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/components/category_chip/category_chip.dart';
import 'package:newsapp/utils/localization.dart';
import '../../../../utils/persistance/settings/settings_prefs.dart';

class CategoriesListBuilder extends StatelessWidget {
  const CategoriesListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    return Container(
      height: 50,
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, i) {
          return const SizedBox(width: 6);
        },
        itemCount: categories["en"]!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                index == 0 ? const EdgeInsets.only(left: 7) : EdgeInsets.zero,
            child: CategoryChip(index: index,lang: lang,),
          );
        },
      ),
    );
  }
}
