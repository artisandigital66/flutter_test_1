import 'package:flutter/material.dart';
import 'package:flutter_test_1/pages/home_page.dart';
import 'package:flutter_test_1/pages/jump_log_page.dart';
import 'package:flutter_test_1/pages/interface_page.dart';
import 'package:flutter_test_1/pages/jump_details_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '${dotenv.env['SUPABASE_PROJECT_URL']}',
    anonKey: '${dotenv.env['SUPABASE_ANON_KEY']}',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  setCurrentPage(int index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 20,
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const [
            Text(
              'Accueil',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Jumps Log',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Interface',
              style: TextStyle(color: Colors.white),
            ),
          ][_currentIndex],
        ),
        body: const [
          HomePage(),
          JumpLogPage(),
          InterfacePage(),
          JumpDetailsPage(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentPage(index),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 20,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_rounded), label: 'Jump Log'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Interface'),
          ],
        ),
      ),
    );
  }
}
