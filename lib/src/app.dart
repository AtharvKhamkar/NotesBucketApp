import 'package:flutter/material.dart';
import 'package:notesbucket/src/res/string.dart';
import 'package:notesbucket/src/views/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: AppStrings.appName,
      home: HomeView(),
    );
  }
}
