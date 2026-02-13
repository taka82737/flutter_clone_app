import 'package:flutter/material.dart';

// Car Detail Provider
class CarDetailProvider extends ChangeNotifier {
  List<Map<String, dynamic>> carTypes = [
    {'type': 'Economy', 'price': 50},
    {'type': 'Comfort', 'price': 75},
    {'type': 'Premium', 'price': 100},
  ];

  String selectedCarType = 'Economy';
  String pickupLocation = '';
  String dropLocation = '';
  Map<String, bool> extras = {
    'luggage': false,
    'music': false,
    'water': false,
  };

  double get baseFare {
    final car = carTypes.firstWhere(
      (c) => c['type'] == selectedCarType,
      orElse: () => {'price': 50},
    );
    return (car['price'] as num).toDouble();
  }

  double get extrasTotal {
    double total = 0;
    if (extras['luggage'] ?? false) total += 50;
    if (extras['music'] ?? false) total += 30;
    if (extras['water'] ?? false) total += 20;
    return total;
  }

  double get totalFare => baseFare + extrasTotal;

  void selectCarType(String type) {
    selectedCarType = type;
    notifyListeners();
  }

  void setPickupLocation(String location) {
    pickupLocation = location;
    notifyListeners();
  }

  void setDropLocation(String location) {
    dropLocation = location;
    notifyListeners();
  }

  void toggleExtra(String extra, bool value) {
    extras[extra] = value;
    notifyListeners();
  }

  void resetProvider() {
    selectedCarType = 'Economy';
    pickupLocation = '';
    dropLocation = '';
    extras = {'luggage': false, 'music': false, 'water': false};
    notifyListeners();
  }
}

// Food Detail Provider
class FoodDetailProvider extends ChangeNotifier {
  List<String> categories = ['All', 'Main Dish', 'Desserts'];
  String selectedCategory = 'All';

  List<Map<String, dynamic>> allItems = [
    {'id': '1', 'name': 'Amok Trey (Fish Amok)', 'price': 25, 'category': 'Main Dish'},
    {'id': '2', 'name': 'Bai Sach Chrouk (Pork & Rice)', 'price': 8, 'category': 'Main Dish'},
    {'id': '3', 'name': 'Nom Banh Chok (Khmer Noodles)', 'price': 4, 'category': 'Main Dish'},
    {'id': '4', 'name': 'Kuy Teav (Beef Noodle Soup)', 'price': 8, 'category': 'Main Dish'},
    {'id': '5', 'name': 'Num Ansom (Sticky Rice Cake)', 'price': 2, 'category': 'Desserts'},
    {'id': '6', 'name': 'Bra Krong (Cambodian Jelly Dessert)', 'price': 5, 'category': 'Desserts'},
  ];

  Map<String, int> selectedItems = {};
  Map<String, double> itemPrices = {};

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<Map<String, dynamic>> getFilteredItems() {
    if (selectedCategory == 'All') {
      return allItems;
    }
    return allItems.where((item) => item['category'] == selectedCategory).toList();
  }

  void addToCart(String itemId, dynamic price, String name) {
    selectedItems[itemId] = (selectedItems[itemId] ?? 0) + 1;
    itemPrices[itemId] = (price as num).toDouble();
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    if ((selectedItems[itemId] ?? 0) > 0) {
      selectedItems[itemId] = selectedItems[itemId]! - 1;
      if (selectedItems[itemId] == 0) {
        selectedItems.remove(itemId);
      }
      notifyListeners();
    }
  }

  int get itemCount {
    int count = 0;
    selectedItems.forEach((_, quantity) => count += quantity);
    return count;
  }

  double get subtotal {
    double total = 0;
    selectedItems.forEach((itemId, quantity) {
      total += (itemPrices[itemId] ?? 0) * quantity;
    });
    return total;
  }

  double get deliveryFee => subtotal > 0 ? 30 : 0;

  double get total => subtotal + deliveryFee;

  void resetProvider() {
    selectedItems = {};
    itemPrices = {};
    selectedCategory = 'All';
    notifyListeners();
  }
}


// Express Detail Provider
class ExpressDetailProvider extends ChangeNotifier {
  String selectedService = 'bike';
  String itemWeight = '';
  String pickupAddress = '';
  String dropAddress = '';
  String deliveryInstructions = '';
  bool codEnabled = false;

  double get baseFee {
    if (selectedService == 'bike') return 40;
    if (selectedService == 'car') return 80;
    return 120; // Van
  }

  double get estimatedFee => baseFee;

  void setService(String service) {
    selectedService = service;
    notifyListeners();
  }

  void setItemWeight(String weight) {
    itemWeight = weight;
    notifyListeners();
  }

  void setPickupAddress(String address) {
    pickupAddress = address;
    notifyListeners();
  }

  void setDropAddress(String address) {
    dropAddress = address;
    notifyListeners();
  }

  void setDeliveryInstructions(String instructions) {
    deliveryInstructions = instructions;
    notifyListeners();
  }

  void toggleCOD(bool value) {
    codEnabled = value;
    notifyListeners();
  }

  void resetProvider() {
    selectedService = 'bike';
    itemWeight = '';
    pickupAddress = '';
    dropAddress = '';
    deliveryInstructions = '';
    codEnabled = false;
    notifyListeners();
  }
}

// Wallet Detail Provider
class WalletDetailProvider extends ChangeNotifier {
  double walletBalance = 5000;
  int selectedTopUpAmount = 500;
  String selectedPaymentMethod = 'Credit Card';
    List<String> paymentMethods = [
    'ABA',
    'Wing',
    'Pi Pay',
    'TrueMoney',
    'ACLEDA'
  ];

  List<Map<String, dynamic>> transactions = [
    {
      'description': 'Ride to Downtown',
      'amount': 250,
      'type': 'debit',
      'date': 'Today 2:30 PM'
    },
    {
      'description': 'Food Order Delivery',
      'amount': 180,
      'type': 'debit',
      'date': 'Yesterday 7:15 PM'
    },
    {
      'description': 'Wallet Top Up',
      'amount': 1000,
      'type': 'credit',
      'date': 'Yesterday 5:00 PM'
    },
  ];

  void setTopUpAmount(int amount) {
    selectedTopUpAmount = amount;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void topUp() {
    walletBalance += selectedTopUpAmount;
    addTransaction('Wallet Top Up', selectedTopUpAmount, 'credit');
    notifyListeners();
  }

  void addTransaction(String description, int amount, String type) {
    transactions.insert(
      0,
      {
        'description': description,
        'amount': amount,
        'type': type,
        'date': 'Just now',
      },
    );
    if (transactions.length > 10) {
      transactions.removeLast();
    }
  }

  void resetProvider() {
    selectedTopUpAmount = 500;
    selectedPaymentMethod = 'Credit Card';
    walletBalance = 5000;
    transactions = [
      {
        'description': 'Ride to Downtown',
        'amount': 250,
        'type': 'debit',
        'date': 'Today 2:30 PM'
      },
      {
        'description': 'Food Order Delivery',
        'amount': 180,
        'type': 'debit',
        'date': 'Yesterday 7:15 PM'
      },
      {
        'description': 'Wallet Top Up',
        'amount': 1000,
        'type': 'credit',
        'date': 'Yesterday 5:00 PM'
      },
    ];
    notifyListeners();
  }
}

// Insurance Detail Provider
class InsuranceDetailProvider extends ChangeNotifier {
  String selectedPlan = 'Basic';
  double selectedInsurancePrice = 2999;
  bool agreeToTerms = false;
  Map<String, bool> expandedFAQs = {
    'How do I claim?': false,
    'Is there a waiting period?': false,
    'What documents do I need?': false,
  };

  void selectPlan(String plan, double price) {
    selectedPlan = plan;
    selectedInsurancePrice = price;
    notifyListeners();
  }

  void toggleFAQ(String faq) {
    expandedFAQs[faq] = !(expandedFAQs[faq] ?? false);
    notifyListeners();
  }

  void toggleTermsAgreement(bool value) {
    agreeToTerms = value;
    notifyListeners();
  }

  void resetProvider() {
    selectedPlan = 'Basic';
    selectedInsurancePrice = 2999;
    agreeToTerms = false;
    expandedFAQs = {
      'How do I claim?': false,
      'Is there a waiting period?': false,
      'What documents do I need?': false,
    };
    notifyListeners();
  }
}

// Gift Card Detail Provider
class GiftCardDetailProvider extends ChangeNotifier {
  String selectedDenomination = '\$50';
  double selectedPrice = 50;
  int quantity = 1;

  double get totalPrice => selectedPrice * quantity;

  void selectDenomination(String denomination, double price) {
    selectedDenomination = denomination;
    selectedPrice = price;
    notifyListeners();
  }

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void resetProvider() {
    selectedDenomination = '\$50';
    selectedPrice = 50;
    quantity = 1;
    notifyListeners();
  }
}
