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
      backgroundColor: const Color(0xFFE5F1F9), // Light background to match Burgan theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF005BAA), // Burgan Bank blue
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checking Account",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  GoRouter.of(context).push('/profile');
                  break;
                case 'Sign out':
                  GoRouter.of(context).go('/signin');
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Sign out'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Refined Balance Section
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: const Color(0xFF005BAA),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    provider.getBalance(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Updated Today',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Withdraw, Deposit, and Transfer buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(context, 'Deposit', Icons.account_balance_wallet, 'deposit'),
                _buildActionButton(context, 'Withdraw', Icons.payment, 'withdraw'),
                _buildActionButton(context, 'Transfer', Icons.compare_arrows, 'transfer'),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              'Transaction History',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Transaction list
            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.currentUser.history.length,
              itemBuilder: (BuildContext context, int index) {
                final transactionType = provider.currentUser.history[index][0];
                final transactionAmount = double.parse(provider.currentUser.history[index][1].toString());
                return _buildTransactionCard(
                  title: transactionType,
                  amount: transactionAmount.toStringAsFixed(2),
                  date: 'Oct 17, 2024', // Placeholder for date
                  icon: _getTransactionIcon(transactionType), // Get special icon for the transaction
                  isCredit: transactionAmount > 0, //(transactionType == "deposit" || transactionType == "transfer"), // Only deposits are credits
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Action Button Builder (Deposit, Withdraw, Transfer)
  Widget _buildActionButton(BuildContext context, String label, IconData icon, String extra) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            shadowColor: Colors.black12,
            elevation: 6,
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
        Text(label, style: const TextStyle(color: Color(0xFF005BAA)))
      ],
    );
  }

  // Get special icon for each transaction type
  IconData _getTransactionIcon(String transactionType) {
    switch (transactionType) {
      case 'deposit':
        return Icons.arrow_upward;
      case 'withdraw':
        return Icons.arrow_downward;
      case 'transfer':
        return Icons.swap_horiz;
      default:
        return Icons.monetization_on;
    }
  }

  // Transaction Card Builder
  Widget _buildTransactionCard({required String title, required String amount, required String date, required IconData icon, required bool isCredit}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFFFFFFFF),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: isCredit ? Colors.green : Colors.red,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              isCredit ? '+\$' + amount : '-\$' + amount,
              style: TextStyle(
                color: isCredit ? Colors.green : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
