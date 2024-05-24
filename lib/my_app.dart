import 'package:flutter/material.dart';
import 'package:flutter_stories_app/route/router.dart';
import 'package:flutter_stories_app/utils/flavor_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: FlavorConfig.instance.color
      ),
      routerConfig: router,
      title: FlavorConfig.instance.flavorValues.titleApp,
    );
  }
}