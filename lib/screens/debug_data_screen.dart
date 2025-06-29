import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DebugDataScreen extends StatefulWidget {
  const DebugDataScreen({Key? key}) : super(key: key);

  @override
  State<DebugDataScreen> createState() => _DebugDataScreenState();
}

class _DebugDataScreenState extends State<DebugDataScreen> {
  Color _getTypeColor(String type) {
    switch (type) {
      case 'tap':
        return Colors.blue.shade100;
      case 'swipe':
        return Colors.green.shade100;
      case 'orientation':
        return Colors.orange.shade100;
      case 'screen_navigation':
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  String _formatTimestamp(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
    } catch (_) {
      return iso;
    }
  }

  String _gripFromXYZ(Map<String, dynamic> e) {
    final x = e['x'] ?? 0.0;
    final y = e['y'] ?? 0.0;
    final z = e['z'] ?? 0.0;
    if (z > 7) return 'Face Up';
    if (z < -7) return 'Face Down';
    if (y.abs() > x.abs()) return y > 0 ? 'Upright' : 'Upside Down';
    return x > 0 ? 'Left Tilt' : 'Right Tilt';
  }

  Future<void> _clearData() async {
    final box = Hive.box('behaviorData');
    await box.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear All Data',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear All Data?'),
                  content: const Text('Are you sure you want to delete all debug data?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await _clearData();
              }
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('behaviorData').listenable(),
        builder: (context, Box box, _) {
          final entries = box.values
              .where((e) => e is Map)
              .toList()
              .cast<Map>()
              .reversed
              .toList();
          if (entries.isEmpty) {
            return const Center(child: Text('No data recorded.'));
          }

          // Group by type
          final Map<String, List<Map>> grouped = {};
          for (final e in entries) {
            final type = e['type'] ?? e['interactionType'] ?? 'Unknown';
            grouped.putIfAbsent(type, () => []).add(e);
          }

          return ListView(
            children: grouped.entries.map((group) {
              final type = group.key;
              final color = _getTypeColor(type);
              // Limit to 150 most recent entries per group
              final groupEntries = group.value.take(150).toList();
              return ExpansionTile(
                initiallyExpanded: false,
                backgroundColor: color.withOpacity(0.3),
                collapsedBackgroundColor: color.withOpacity(0.15),
                title: Text(
                  type[0].toUpperCase() + type.substring(1),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: groupEntries.map((e) {
                  final screen = e['screen'] ?? e['screenName'] ?? '-';
                  final ts = e['timestamp'] ?? '-';
                  return Card(
                    color: color,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(
                        type[0].toUpperCase() + type.substring(1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (screen != '-') Text('Screen: $screen'),
                          if (type == 'tap' || type == 'swipe')
                            Text('Position: x=${e['position']?['x']?.toStringAsFixed(2)}, y=${e['position']?['y']?.toStringAsFixed(2)}'),
                          if (type == 'orientation')
                            Text('x=${e['x']?.toStringAsFixed(2)}, y=${e['y']?.toStringAsFixed(2)}, z=${e['z']?.toStringAsFixed(2)} (${_gripFromXYZ(Map<String, dynamic>.from(e))})'),
                          if (type == 'screen_navigation')
                            Text('Visited: $screen'),
                          Text('Time: ${_formatTimestamp(ts)}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
} 