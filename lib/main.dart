import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/data/api/source_api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/source.dart';
import 'package:newsapp/ui/screens/main_screen.dart';
import 'package:newsapp/ui/theme/theme.dart';
import 'package:newsapp/ui/theme/theme_provider.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Article.registerAdapter();
  Source.registerAdapter();
  await Hive.initFlutter();
  await SettingsPrefs.openBox();
  SettingsPrefs.initBox();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_)=>NewsAPI()),
        ChangeNotifierProvider(create: (_)=>SourceAPI())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SourceAPI>(context,listen: false).fetchAllSource();
    return MaterialApp(
      title: 'News App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: Provider.of<AppThemeProvider>(context,listen: true).isItDark?ThemeMode.dark:ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
