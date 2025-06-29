import 'package:flutter/material.dart';
import 'package:raksha/widgets/app_drawer.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF667EEA),
        title: const Text('Savings Account'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAccountSummaryCard(),
          const SizedBox(height: 16),
          _buildStatementSection(),
        ],
      ),
    );
  }

  Widget _buildAccountSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Savings Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'XXXX XXXX XXXX 1234',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Available Balance',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '₹XX,XXX',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF667EEA)),
                    ),
                    Text(
                      '.XX',
                      style: TextStyle(fontSize: 18, color: Color(0xFF667EEA)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '(Account Balance + Overdraft - Hold)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _showDetails = !_showDetails;
                          });
                        },
                        icon: Icon(_showDetails ? Icons.expand_less : Icons.expand_more, color: const Color(0xFF667EEA)),
                        label: Text(
                          _showDetails ? 'Hide Account Details' : 'Show Account Details',
                          style: const TextStyle(color: Color(0xFF667EEA)),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showDetails) _buildAccountDetails(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, color: Color(0xFF667EEA)),
                        label: const Text(
                          'Share Account Details',
                          style: TextStyle(color: Color(0xFF667EEA)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF667EEA)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Divider(),
          SizedBox(height: 8),
          Text('Account Holders: John Doe', style: TextStyle(fontSize: 14)),
          Text('Branch: Example Branch', style: TextStyle(fontSize: 14)),
          Text('IFSC: ABCD0123456', style: TextStyle(fontSize: 14)),
          Text('MMID: Generate', style: TextStyle(fontSize: 14, color: Color(0xFF667EEA))),
          Text('Virtual Payment Address: Register', style: TextStyle(fontSize: 14, color: Color(0xFF667EEA))),
          Text('Account Balance: ₹XX,XXX.XX', style: TextStyle(fontSize: 14)),
          Text('Required Monthly Average Balance: ₹X,XXX.XX', style: TextStyle(fontSize: 14)),
          Text('Uncleared Funds: ₹0.00', style: TextStyle(fontSize: 14)),
          Text('Amount on Hold: ₹0.00', style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text('Linked Cards:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text('Primary Card: XXXX********1234', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStatementSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Statement', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF667EEA))),
                Icon(Icons.expand_more, color: Color(0xFF667EEA)),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecentTransaction(
              date: '01 Jan 2025',
              amount: '₹100.00',
              isCredit: false,
              description: 'UPI-XXXX-... Payment from App',
              balance: '₹XX,XXX.XX',
            ),
            _buildRecentTransaction(
              date: '31 Dec 2024',
              amount: '₹250.00',
              isCredit: true,
              description: 'UPI-YYYY-... Payment',
              balance: '₹XX,XXX.XX',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransaction({
    required String date,
    required String amount,
    required bool isCredit,
    required String description,
    required String balance,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 2),
              Text(description, style: const TextStyle(fontSize: 12, color: Colors.black87)),
              Text('Balance: $balance', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isCredit ? Colors.green : Colors.red)),
              Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? Colors.green : Colors.red, size: 18),
            ],
          ),
        ],
      ),
    );
  }
} 