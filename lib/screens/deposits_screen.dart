import 'package:flutter/material.dart';
import 'package:raksha/widgets/app_drawer.dart';

class DepositsScreen extends StatelessWidget {
  const DepositsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF667EEA),
        title: const Text('Deposits'),
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
                  Text('Fixed Deposit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA))),
                  SizedBox(height: 8),
                  Text('Principal: ₹50,000', style: TextStyle(fontSize: 14)),
                  Text('Interest Rate: 6.5%', style: TextStyle(fontSize: 14)),
                  Text('Maturity Date: 01 Jan 2026', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 12),
                  Text('Maturity Amount: ₹53,250', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF667EEA))),
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
                  Text('Recent Deposits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA))),
                  SizedBox(height: 12),
                  Text('No recent deposits.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 