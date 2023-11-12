import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/theme_provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/screens/splash/screen/splash_screen.dart';
import 'package:todo/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,themeProvider,child) {
        return MaterialApp(
          title: 'Todo App',
          theme: themeProvider.darkTheme ? buildDarkTheme() : buildLightTheme(),
          home: const SplashScreen(),
        );
      }
    );
  }
}




