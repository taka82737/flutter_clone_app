import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      {
        'title': 'Grab Support',
        'subtitle': 'How was your last ride?',
        'time': '2 min ago',
        'unread': 1,
      },
      {
        'title': 'Driver • Sok',
        'subtitle': 'I am arriving in 2 mins',
        'time': 'Today',
        'unread': 0,
      },
      {
        'title': 'Restaurant • Bay Khmer',
        'subtitle': 'Your order has been picked up',
        'time': 'Yesterday',
        'unread': 0,
      },
      {
        'title': 'Promotions',
        'subtitle': 'Get 50% off on your next ride',
        'time': '2 days ago',
        'unread': 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(35, 154, 63, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: conversations.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final convo = conversations[index];
          final unread = convo['unread'] as int;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: Icon(
                index == 0
                    ? Icons.support_agent
                    : index == 1
                        ? Icons.directions_car
                        : index == 2
                            ? Icons.fastfood
                            : Icons.campaign,
                color: Colors.green,
                size: 20,
              ),
            ),
            title: Text(
              convo['title'] as String,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight:
                    unread > 0 ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            subtitle: Text(
              convo['subtitle'] as String,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  convo['time'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                if (unread > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      unread.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
