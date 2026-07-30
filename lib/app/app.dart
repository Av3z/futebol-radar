import 'package:flutter/material.dart';

import 'router.dart';

class FutebolRadarApp extends StatefulWidget {
  const FutebolRadarApp({super.key});

  @override
  State<FutebolRadarApp> createState() => _FutebolRadarAppState();
}

class _FutebolRadarAppState extends State<FutebolRadarApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Futebol Radar',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff176b5b), brightness: Brightness.light),
          useMaterial3: true),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff68d3b6), brightness: Brightness.dark),
          useMaterial3: true),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
