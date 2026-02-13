import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_screens/car_detail_screen.dart';
import 'detail_screens/food_detail_screen.dart';
import 'detail_screens/express_detail_screen.dart';
import 'detail_screens/wallet_detail_screen.dart';
import 'detail_screens/insurance_detail_screen.dart';
import 'detail_screens/gift_card_detail_screen.dart';

class GrabHomeScreen extends StatefulWidget {
  const GrabHomeScreen({super.key});

  @override
  State<GrabHomeScreen> createState() => _GrabHomeScreenState();
}

class _GrabHomeScreenState extends State<GrabHomeScreen> {
  late PageController _carouselController;
  int _currentCarouselIndex = 0;
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
    _startCarouselTimer();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_carouselController.hasClients) {
        final promoImages = [
          'assets/ads.jpg',
          'assets/ads1.png',
          'assets/ads2.jpg',
          'assets/ads3.jpg',
          'assets/ads4.jpg',
          'assets/ads5.jpg',
        ];
        final nextIndex = (_currentCarouselIndex + 1) % promoImages.length;
        _carouselController.animateToPage(
          nextIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/grab_logo.png',
            width: 50,
            height: 50,
          ),
        ),
        backgroundColor: Color.fromRGBO(35, 154, 63, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search the Grab app',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            // Wallet Row
            _buildWalletRow(),

            // Top Up Buttons
            _buildTopUpButton(context),

            // Promo Carousel
            _buildPromoCarousel(),

            // Services Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildServicesGrid(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet Balance',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$5000',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rewards',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              Text(
                '401 pts',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildTopUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WalletDetailScreen(),
              ),
            );
          },
          child: Text(
            'Wallet',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final promoImages = [
      'assets/ads.jpg',
      'assets/ads1.png',
      'assets/ads2.jpg',
      'assets/ads3.jpg',
      'assets/ads4.jpg',
      'assets/ads5.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _carouselController,
              onPageChanged: (index) {
                setState(() => _currentCarouselIndex = index);
              },
              itemCount: promoImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    promoImages[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              promoImages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarouselIndex == index
                      ? Colors.green
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'title': 'Car',
        'asset': 'assets/grids/car.png',
        'screen': const CarDetailScreen(),
      },
      {
        'title': 'Food',
        'asset': 'assets/grids/food.png',
        'screen': const FoodDetailScreen(),
      },
      {
        'title': 'Express',
        'asset': 'assets/grids/delivery.png',
        'screen': const ExpressDetailScreen(),
      },
      {
        'title': 'Insurance',
        'asset': 'assets/grids/crown.png',
        'screen': const InsuranceDetailScreen(),
      },
      {
        'title': 'Gift Cards',
        'asset': 'assets/gift.png',
        'screen': const GiftCardDetailScreen(),
      },
      {
        'title': 'More',
        'asset': 'assets/grids/more.png',
        'screen': null,
      },
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: services.map((service) {
        return GestureDetector(
          onTap: service['screen'] != null ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => service['screen'] as Widget,
              ),
            );
          } : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  service['asset'] as String,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 8),
              Text(
                service['title'] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

