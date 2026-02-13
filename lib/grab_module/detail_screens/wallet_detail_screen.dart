import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_providers.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/bottom_cta_button.dart';

class WalletDetailScreen extends StatefulWidget {
  const WalletDetailScreen({super.key});

  @override
  State<WalletDetailScreen> createState() => _WalletDetailScreenState();
}

class _WalletDetailScreenState extends State<WalletDetailScreen> {
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletDetailProvider>(context, listen: false).resetProvider();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(35, 154, 63, 1),
      ),
      body: Consumer<WalletDetailProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wallet Balance Card
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade600],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Balance',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$${provider.walletBalance.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Verified',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Up Section
                      Text(
                        'Top Up Wallet',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Quick Amount Buttons
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: [100, 250, 500, 1000]
                            .map((amount) {
                          final isSelected =
                              provider.selectedTopUpAmount == amount;
                          return GestureDetector(
                            onTap: () =>
                                provider.setTopUpAmount(amount),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius:
                                    BorderRadius.circular(8),
                                color: isSelected
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.white,
                              ),
                              child: Center(
                            child: Text(
                              '\$$amount',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),

                      // Custom Amount
                      TextField(
                        controller: _amountController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            provider
                                .setTopUpAmount(int.tryParse(value) ?? 0);
                          }
                        },
                        decoration: InputDecoration(
                          prefixText: '\$ ',
                          hintText: 'Enter custom amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 24),

                      // Payment Methods
                      Text(
                        'Top Up Method',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: provider.paymentMethods.map((method) {
                          final isSelected =
                              provider.selectedPaymentMethod ==
                                  method;
                          return ListTile(
                            leading: Icon(Icons.payment,
                                color:
                                    isSelected ? Colors.green : null),
                            title: Text(
                              method,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: Radio<String>(
                              value: method,
                              groupValue:
                                  provider.selectedPaymentMethod,
                              onChanged: (value) =>
                                  provider.setPaymentMethod(
                                      value ?? ''),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24),

                      // Transaction History
                      Text(
                        'Recent Transactions',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: provider.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction =
                              provider.transactions[index];
                          return ListTile(
                            leading: Icon(
                              transaction['type'] == 'credit'
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: transaction['type'] == 'credit'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            title: Text(
                              transaction['description'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(
                              transaction['date'],
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Text(
                              '${transaction['type'] == 'credit' ? '+' : '-'}\$${transaction['amount']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    transaction['type'] == 'credit'
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<WalletDetailProvider>(
        builder: (context, provider, _) {
          return BottomCTAButton(
            label: 'Add Money',
            price: provider.selectedTopUpAmount.toDouble(),
            onPressed: () {
              provider.topUp();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '\$${provider.selectedTopUpAmount} added to wallet!'),
                ),
              );
              _amountController.clear();
            },
          );
        },
      ),
    );
  }
}
