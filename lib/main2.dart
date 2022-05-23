import 'package:flutter/material.dart';

void main() => runApp(new MainApp());

// Mock up of an async backend service
Future getData() async {
  return Future.delayed(Duration(seconds: 1), () => {2});
}

class PageOne extends StatelessWidget {
  int data;

  PageOne({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: const Text('update preferences'),
        onPressed: () {
          data = 2;
        },
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  int data;

  PageTwo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Got It!'),
        onPressed: () {
          print("data is now: [$data]");
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //Map<String, dynamic> Data;
  late int data;

  /*
  StartFunc() async {
    Data = await getData();
    setState(() {});
  }
  */

  @override
  void initState() {
    //StartFunc();
    super.initState();
    getData().then((values) {
      setState(() {
        data = values;
      });
    });
  }

  /*
  PageOne(data:data) is an invalid value for an initializer:
   there is no way to access this at this point.
    Initializers are executed before the constructor,
    but this is only allowed to be accessed after the call
    to the super constructor.

  */
  /*
  var _pages = [
    PageOne(data:data),
    PageTwo(),
  ];
  */

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return PageOne(data: data);
        break;
      case 1:
        return PageTwo(data: data);
        break;
      default:
        return PageOne(data: data);
        break;
    }
  }

  int _currentIndex = 0;

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    return _currentIndex == 2
        ? PageTwo()
        : Scaffold(

    I use a MaterialApp because of material widgets (RaisedButton)
    It is not mandatory, but it is mainstream in flutter

     */
    return MaterialApp(
        title: 'My App',
        home: Scaffold(
          appBar: AppBar(title: Text("My App Bar")),
          body: getPage(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.first_page), label: "1"),
              BottomNavigationBarItem(icon: Icon(Icons.last_page), label: "2"),
            ],
            onTap: onTabTapped,
            currentIndex: _currentIndex,
          ),
        ));
  }
}
