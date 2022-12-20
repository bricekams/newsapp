import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/bookmarks/bookmarks.dart';
import 'package:newsapp/ui/screens/settings/settings.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      body: screens[Provider.of<NavBarProvider>(context,listen:true).getCurrentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: Provider.of<NavBarProvider>(context,listen:true).getCurrentIndex,
        onDestinationSelected: (i){
          Provider.of<NavBarProvider>(context,listen:false).setCurrentIndex = i;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmarks),
            label: 'Bookmark',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}


