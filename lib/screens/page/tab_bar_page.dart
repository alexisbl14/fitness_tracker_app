import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitness_tracker_app/screens/home/home_page.dart';
import 'package:fitness_tracker_app/screens/workouts/workouts_page.dart';
import 'package:fitness_tracker_app/screens/settings/settings_page.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;
  int data = 0;
  static const List<Widget> _tabBarOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Workouts',
    ),
    Text(
      'Index 2: Settings',
    ),
  ];

  Widget _createTabBody(BuildContext context, int index) {
    final children = [
      HomePage(data: data),
      WorkoutsPage(data: data),
      SettingsScreen()
    ];
    return children[index];
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _createTabBody(context, _selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              bottomNavBarBoxShadow(),
            ],
          ),
          child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/icons/home_icon.png")),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon:
                        ImageIcon(AssetImage("assets/icons/workouts_icon.png")),
                    label: 'Workouts'),
                BottomNavigationBarItem(
                    icon:
                        ImageIcon(AssetImage("assets/icons/settings_icon.png")),
                    label: 'Settings'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 186, 56, 209),
              onTap: _onTabTapped,
              elevation: 10.0),
        ),
      ),
    );
  }

  BoxShadow bottomNavBarBoxShadow() {
    return const BoxShadow(
      color: Color.fromARGB(255, 174, 173, 173),
      blurRadius: 1,
    );
  }
}
