import 'package:flutter/material.dart';
import 'package:raksha/widgets/app_drawer.dart';

class SafeDepositLockersScreen extends StatelessWidget {
  const SafeDepositLockersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF667EEA),
        title: const Text('Safe Deposit Lockers'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Locker Number: 101', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA))),
                  SizedBox(height: 8),
                  Text('Type: Medium', style: TextStyle(fontSize: 14)),
                  Text('Status: Active', style: TextStyle(fontSize: 14)),
                  Text('Annual Rent: ₹2,000', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 12),
                  Text('Next Due Date: 01 Jan 2025', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF667EEA))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Locker Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA))),
                  SizedBox(height: 12),
                  Text('No recent activity.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 