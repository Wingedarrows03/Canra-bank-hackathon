import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GestureCaptureWrapper extends StatelessWidget {
  final Widget child;
  final String screenName;

  const GestureCaptureWrapper({
    Key? key,
    required this.child,
    required this.screenName,
  }) : super(key: key);

  void _storeInteraction({
    required String type,
    required Offset position,
  }) async {
    final box = Hive.box('behaviorData');
    final interaction = {
      'interactionType': type,
      'screenName': screenName,
      'position': {'x': position.dx, 'y': position.dy},
      'timestamp': DateTime.now().toIso8601String(),
    };
    await box.add(interaction);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        _storeInteraction(type: 'tap', position: details.globalPosition);
      },
      onPanUpdate: (details) {
        _storeInteraction(type: 'swipe', position: details.globalPosition);
      },
      child: child,
    );
  }
} 