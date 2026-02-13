import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_providers.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/bottom_cta_button.dart';
import 'widgets/expandable_section.dart';

class InsuranceDetailScreen extends StatefulWidget {
  const InsuranceDetailScreen({super.key});

  @override
  State<InsuranceDetailScreen> createState() => _InsuranceDetailScreenState();
}

class _InsuranceDetailScreenState extends State<InsuranceDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InsuranceDetailProvider>(context, listen: false)
          .resetProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        title: 'Grab Insurance',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Consumer<InsuranceDetailProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade600,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shield,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Comprehensive Coverage',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Summary
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Protect Your Rides',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Our comprehensive insurance covers accidents, theft, and medical emergencies. Travel with peace of mind.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Coverage List
                      Text(
                        'What\'s Covered',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildCoverageItem('Accident Protection', '\$5,000'),
                          _buildCoverageItem('Theft Coverage', '\$3,000'),
                          _buildCoverageItem(
                              'Medical Emergency', '\$1,000'),
                          _buildCoverageItem(
                              'Personal Belongings', '\$500'),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Plan Selection
                      Text(
                        'Choose Your Plan',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildPlanCard(
                            context,
                            provider,
                            'Basic',
                            '\$29.99',
                            '/year',
                            [
                              'Accident Protection',
                              'Emergency Medical',
                              'Basic Coverage'
                            ],
                          ),
                          _buildPlanCard(
                            context,
                            provider,
                            'Standard',
                            '\$39.99',
                            '/year',
                            [
                              'All Basic Benefits',
                              'Theft Coverage',
                              'Enhanced Limits'
                            ],
                          ),
                          _buildPlanCard(
                            context,
                            provider,
                            'Premium',
                            '\$49.99',
                            '/year',
                            [
                              'All Standard Benefits',
                              'Maximum Coverage',
                              'Priority Support'
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // FAQ Section
                      Text(
                        'Frequently Asked Questions',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ExpandableSection(
                        title: 'How do I claim?',
                        child: Text(
                          'You can file a claim through the Grab app within 48 hours of the incident. Provide necessary documents and our support team will guide you through the process.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ExpandableSection(
                        title: 'Is there a waiting period?',
                        child: Text(
                          'Yes, new policies have a 7-day waiting period for accident claims. Emergency medical claims can be filed immediately.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ExpandableSection(
                        title: 'What documents do I need?',
                        child: Text(
                          'For accident claims: Police FIR, medical reports, photos, and repair bills. For theft: Police complaint, proof of ownership, and policy details.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Terms & Conditions
                      CheckboxListTile(
                        title: Text(
                          'I agree to the terms and conditions',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        value: provider.agreeToTerms,
                        onChanged: (value) => provider
                            .toggleTermsAgreement(value ?? false),
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
      bottomNavigationBar: Consumer<InsuranceDetailProvider>(
        builder: (context, provider, _) {
          return BottomCTAButton(
            label: 'Request Delivery',
            price: provider.selectedInsurancePrice,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Insurance plan activated successfully!'),
                ),
              );
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Widget _buildCoverageItem(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    InsuranceDetailProvider provider,
    String planName,
    String price,
    String period,
    List<String> features,
  ) {
    final isSelected = provider.selectedPlan == planName;
    final priceValue = planName == 'Basic'
        ? 2999.0
        : planName == 'Standard'
            ? 3999.0
            : 4999.0;

    return GestureDetector(
      onTap: () => provider.selectPlan(planName, priceValue),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color:
              isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  planName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio<String>(
                  value: planName,
                  groupValue: provider.selectedPlan,
                  onChanged: (value) =>
                      provider.selectPlan(value ?? '', priceValue),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '$price$period',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check,
                                size: 16, color: Colors.green),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
