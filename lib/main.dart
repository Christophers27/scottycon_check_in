import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'homepage.dart';
import 'gsheets_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GoogleSheetsApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ScottyCon Check-In",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(201, 255, 20, 20))),
        home: const HomePage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
}
