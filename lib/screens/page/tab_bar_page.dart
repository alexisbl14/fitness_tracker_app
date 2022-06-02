import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker_app/screens/page/sign_in_screen.dart';
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
    final children = [HomePage(), WorkoutsPage(), SettingsScreen()];
    return children[index];
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final pages = [HomePage(), WorkoutsPage(), SettingsScreen()];

  User? _user;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInScreen();
    } else {
      return SafeArea(
        child: Scaffold(
          //body: Center(
          //  child: _createTabBody(context, _selectedIndex),
          //),
          body: IndexedStack(
            index: _selectedIndex,
            children: pages,
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
  }

  BoxShadow bottomNavBarBoxShadow() {
    return const BoxShadow(
      color: Color.fromARGB(255, 174, 173, 173),
      blurRadius: 1,
    );
  }
}
