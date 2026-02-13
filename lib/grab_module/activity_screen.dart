import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Ride to Norton',
        'subtitle': 'Today • 2:30 PM',
        'amount': '-\$4',
        'type': 'ride',
      },
      {
        'title': 'Food Order - Bay Srok Yerng',
        'subtitle': 'Yesterday • 8:15 PM',
        'amount': '-\$15',
        'type': 'food',
      },
      {
        'title': 'Grab Mart - Groceries',
        'subtitle': 'Yesterday • 6:05 PM',
        'amount': '-\$99',
        'type': 'mart',
      },
      {
        'title': 'Wallet Top Up',
        'subtitle': '2 days ago • 4:00 PM',
        'amount': '+\$1000',
        'type': 'topup',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(35, 154, 63, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Last 30 days',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: activities.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final activity = activities[index];
                final isCredit = (activity['amount'] as String).startsWith('+');

                IconData icon;
                Color iconColor;
                switch (activity['type']) {
                  case 'ride':
                    icon = Icons.directions_car;
                    iconColor = Colors.green;
                    break;
                  case 'food':
                    icon = Icons.fastfood;
                    iconColor = Colors.orange;
                    break;
                  case 'mart':
                    icon = Icons.shopping_cart;
                    iconColor = Colors.blue;
                    break;
                  case 'topup':
                    icon = Icons.account_balance_wallet;
                    iconColor = Colors.green;
                    break;
                  default:
                    icon = Icons.receipt_long;
                    iconColor = Colors.grey;
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: iconColor.withOpacity(0.1),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  title: Text(
                    activity['title'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    activity['subtitle'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Text(
                    activity['amount'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isCredit ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
