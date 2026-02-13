import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_providers.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/bottom_cta_button.dart';
import 'widgets/expandable_section.dart';

class ExpressDetailScreen extends StatefulWidget {
  const ExpressDetailScreen({super.key});

  @override
  State<ExpressDetailScreen> createState() => _ExpressDetailScreenState();
}

class _ExpressDetailScreenState extends State<ExpressDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpressDetailProvider>(context, listen: false).resetProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        title: 'Grab Express',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Consumer<ExpressDetailProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Icon
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Fast & Reliable Delivery',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Pickup Location
                  ExpandableSection(
                    title: 'Pickup Location',
                    initiallyExpanded: true,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) =>
                              provider.setPickupAddress(value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'Pickup Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Drop Location
                  ExpandableSection(
                    title: 'Drop Location',
                    initiallyExpanded: true,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) =>
                              provider.setDropAddress(value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on_outlined),
                            labelText: 'Drop Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Package Details
                  ExpandableSection(
                    title: 'Package Details',
                    initiallyExpanded: true,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) =>
                              provider.setItemWeight(value),
                          decoration: InputDecoration(
                            labelText: 'Weight (kg)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Item Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Service Options
                  ExpandableSection(
                    title: 'Service Type',
                    initiallyExpanded: true,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Bike'),
                          subtitle: Text('Fast & Economical'),
                          trailing: Radio<String>(
                            value: 'bike',
                            groupValue: provider.selectedService,
                            onChanged: (value) =>
                                provider.setService(value ?? ''),
                          ),
                        ),
                        ListTile(
                          title: Text('Car'),
                          subtitle: Text('Comfortable & Safe'),
                          trailing: Radio<String>(
                            value: 'car',
                            groupValue: provider.selectedService,
                            onChanged: (value) =>
                                provider.setService(value ?? ''),
                          ),
                        ),
                        ListTile(
                          title: Text('Van'),
                          subtitle: Text('Large Packages'),
                          trailing: Radio<String>(
                            value: 'van',
                            groupValue: provider.selectedService,
                            onChanged: (value) =>
                                provider.setService(value ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Delivery Instructions
                  ExpandableSection(
                    title: 'Delivery Instructions',
                    child: TextField(
                      onChanged: (value) =>
                          provider.setDeliveryInstructions(value),
                      decoration: InputDecoration(
                        labelText: 'Special Instructions',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 12),

                  // COD Option
                  CheckboxListTile(
                    title: Text('Cash on Delivery'),
                    value: provider.codEnabled,
                    onChanged: (value) =>
                        provider.toggleCOD(value ?? false),
                  ),
                  SizedBox(height: 12),

                  // Fee Estimate
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fee Estimate',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Base Delivery Fee',
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            Text(
                              '\$${provider.estimatedFee.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\u0024${provider.estimatedFee.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ExpressDetailProvider>(
        builder: (context, provider, _) {
          return BottomCTAButton(
            label: 'Request Delivery',
            price: provider.estimatedFee,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delivery request submitted!'),
                ),
              );
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
