import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/ui/screens/main_screen.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:newsapp/theme/theme_provider.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await SettingsPrefs.openBox();
  SettingsPrefs.initBox();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: Provider.of<AppThemeProvider>(context,listen: true).isItDark?ThemeMode.dark:ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
