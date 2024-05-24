import 'package:flutter/material.dart';
import 'package:flutter_stories_app/utils/flavor_type.dart';

class FlavorConfig {
  final FlavorType flavorType;
  final MaterialColor color;
  final FlavorValues flavorValues;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavorType = FlavorType.free,
    this.color = Colors.green,
    this.flavorValues = const FlavorValues()
  }) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}