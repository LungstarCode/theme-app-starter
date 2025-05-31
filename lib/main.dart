import 'package:exam_prep1/database_helper.dart';
import 'package:exam_prep1/screen_one.dart';
import 'package:exam_prep1/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDarkMode = await DatabaseHelper.instance.getThemePreference();
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  void _updateTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (context, state) => ScreenOne()),
        GoRoute(
          path: "/settings",
          builder:
              (context, state) => Settings(
                isDarkMode: _isDarkMode,
                onThemeChanged: _updateTheme,
              ),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: "SQLite Theme App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
