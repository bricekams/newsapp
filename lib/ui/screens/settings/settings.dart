import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/data/api/api.dart';
import 'package:newsapp/ui/screens/settings/components/setting_section.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';
import 'components/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                dictionary["@settings"][box.get("lang")]
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Preferences
                  SettingSection(
                    title: dictionary["@preferences"][box.get("lang")],
                    tiles: [
                      SettingTile(
                        leading: Icon(box.get("darkMode")?Icons.nights_stay_outlined:Icons.sunny),
                        title: dictionary["@darkMode"][box.get("lang")],
                        trailing: Switch(
                          value: box.get('darkMode'),
                          onChanged: (value) {
                            SettingsPrefs.setDarkTheme(context,value);
                          },
                        ),
                      ),
                      SettingTile(
                        leading: const Icon(Icons.language),
                        title: dictionary["@language"][box.get("lang")],
                        trailing: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: box.get("darkMode")?Colors.white12:Colors.black12,
                            borderRadius: const BorderRadius.all(Radius.circular(50))
                          ),
                          child: GestureDetector(
                            onTap: () {
                              SettingsPrefs.setLang();
                              Provider.of<NewsAPI>(context,listen: false).fetchNewsCategory();
                            },
                            child: Text(
                              dictionary["@currentLang"][box.get("lang")],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /// Browser Settings
                  SettingSection(
                    title: dictionary["@browserSettings"][box.get("lang")],
                    tiles: [
                      SettingTile(
                        leading: const Icon(Icons.javascript),
                        title: dictionary["@jsMode"][box.get("lang")],
                        trailing: Switch(
                          value: box.get("jsMode"),
                          onChanged: (value) {
                            SettingsPrefs.setJsMode(value);
                          },
                        ),
                      ),
                      SettingTile(
                        leading: const Icon(Icons.recycling),
                        title: "Cache",
                        trailing: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              /// Credits
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: const [
                      TextSpan(
                        text: '1.0.0\n'
                      ),
                      TextSpan(
                        text: 'Brice Kam\'s ❤'
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
