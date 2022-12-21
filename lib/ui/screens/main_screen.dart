import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:provider/provider.dart';
import 'bookmarks/bookmarks.dart';
import 'settings/settings.dart';
import 'home/home.dart';

class NavBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get getCurrentIndex => _currentIndex;
  set setCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = const [
      HomeScreen(),
      BookmarksScreen(),
      SettingsScreen()
    ];

    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context,box,child){
        return Scaffold(
          body: screens[Provider.of<NavBarProvider>(context,listen:true).getCurrentIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: Provider.of<NavBarProvider>(context,listen:true).getCurrentIndex,
            onDestinationSelected: (i){
              Provider.of<NavBarProvider>(context,listen:false).setCurrentIndex = i;
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home),
                label: dictionary["@home"][box.get("lang")],
              ),
              NavigationDestination(
                icon: const Icon(Icons.bookmarks),
                label: dictionary["@bookmarks"][box.get("lang")],
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings),
                label: dictionary["@settings"][box.get("lang")],
              ),
            ],
          ),
        );
      },
    );
  }
}


