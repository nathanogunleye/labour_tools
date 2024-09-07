import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labour_tools/about/about_page.dart';
import 'package:labour_tools/event_message_generator/event_message_generator_page.dart';
import 'package:labour_tools/firebase_options.dart';
import 'package:labour_tools/home/home_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

const int labourPrimaryColorInt = 0xFFE4003B;
const Color labourPrimaryColor = Color(0xFFE4003B);

const MaterialColor labourMaterialRed = MaterialColor(
  labourPrimaryColorInt,
  <int, Color>{
    50: Color(0xFFE4003B),
    100: Color(0xFFE4003B),
    200: Color(0xFFE4003B),
    300: Color(0xFFE4003B),
    400: Color(0xFFE4003B),
    500: Color(labourPrimaryColorInt),
    600: Color(0xFFE4003B),
    700: Color(0xFFE4003B),
    800: Color(0xFFE4003B),
    900: Color(0xFFE4003B),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labour Tools',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: labourPrimaryColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: labourMaterialRed,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: labourPrimaryColor,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    EventMessageGeneratorPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Labour Tools',
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: labourPrimaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Events Message Generator'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('About'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
