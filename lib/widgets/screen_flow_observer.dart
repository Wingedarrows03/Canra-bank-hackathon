import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenFlowObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final box = Hive.box('behaviorData');
    final screenName = route.settings.name ?? 'Unknown';
    final navigationData = {
      'type': 'screen_navigation',
      'screen': screenName,
      'timestamp': DateTime.now().toIso8601String(),
    };
    box.add(navigationData);
  }
} 