import 'dart:io';

import 'package:copy_shift/pages/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosApp(
        title: 'CopyShift',
        theme: MacosThemeData.light(),
        darkTheme: MacosThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
    } else {
      return MaterialApp(
        title: 'CopyShift',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
    }
  }
}
