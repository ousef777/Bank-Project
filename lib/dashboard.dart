import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: const Color(0xFFE5F1F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF005BAA), // Consistent with sign-in page
        title: const Text("Dashboard"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust the padding to fit the logo
          child: Image.asset('assets/images/burgan.jpg'), // Add your image here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              GoRouter.of(context).go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Display
            Center(
              child: Column(
                children: [
                  const Text(
                    'CHECKING',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${provider.getBalance().replaceAll('Balance: \$', '')}', // Format balance
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'AVAILABLE BALANCE',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                 
                ],
              ),
            ),
            const SizedBox(height: 20),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(context, 'Deposit', Icons.account_balance_wallet, 'deposit'),
                _buildActionButton(context, 'Pay', Icons.payment, 'withdraw'),
                _buildActionButton(context, 'Transfer', Icons.compare_arrows, 'transfer'),
              ],
            ),
            const SizedBox(height: 30),
           
            const Text(
              'Activity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTransactionItem('Scooter\'s Coffee', '-\$7.39', 'Restaurants & Dining'),
            _buildTransactionItem('ATM Fee', '-\$2.00', 'Service Charges & Fees'),
            _buildTransactionItem('Transfer from x0855', '-\$73.50', 'Other Expenses'),
            _buildTransactionItem('Share 1000', '\$70.00', 'Other Income'),
          ],
        ),
      ),
    );
  }

  // Action Button Builder
  Widget _buildActionButton(BuildContext context, String label, IconData icon, String extra) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {
            GoRouter.of(context).push('/transfer', extra: extra);
          },
          child: Icon(
            icon,
            color: const Color(0xFF005BAA),
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.black))
      ],
    );
  }

  // Transaction Item Builder
  Widget _buildTransactionItem(String title, String amount, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: const TextStyle(color: Colors.black54)),
            Text(
              'Sep 18, 2024',
              style: const TextStyle(color: Colors.black54),
            )
          ],
        ),
        trailing: Text(amount, style: const TextStyle(fontSize: 18, color: Colors.black)),
      ),
    );
  }
}
