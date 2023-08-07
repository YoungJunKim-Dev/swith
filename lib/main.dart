import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:swith/screens/home_screen.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
void main() {
  runApp(const App());
  // logger demo
  // demo();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Swith',
      theme: ThemeData(
        fontFamily: 'Nanum Square Round',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffFF9494), brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff00ADB5), brightness: Brightness.dark)),
      themeMode: ThemeMode.system,
    );
  }
}

void demo() {
  logger.d('Log message with 2 methods');

  loggerNoStack.i('Info message');

  loggerNoStack.w('Just a warning!');

  logger.e('Error! Something bad happened', 'Test Error');

  loggerNoStack.v({'key': 5, 'value': 'something'});

  Logger(printer: SimplePrinter(colors: true)).v('boom');
}
