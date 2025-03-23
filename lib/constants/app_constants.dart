import 'package:flutter/material.dart';

class AppConstants {
  static const List<String> categories = [
    'Food',
    'Travel',
    'Subscriptions',
    'Shopping',
  ];
  static Map<String, dynamic> getCategoryData(String category) {
    const Map<String, Map<String, dynamic>> categoryData = {
      'Food': {
        'icon': 'assets/images/food.svg',
        'color': Color(0xffFDD5D7),
      },
      'Travel': {
        'icon': 'assets/images/travel.svg',
        'color': Color(0xffF1F1FA),
      },
      'Subscriptions': {
        'icon': 'assets/images/subscriptions.svg',
        'color': Color(0xffEEE5FF),
      },
      'Shopping': {
        'icon': 'assets/images/shopping.svg',
        'color': Color(0xffFCEED4),
      },
    };

    return categoryData[category] ??
        {
          'icon': 'assets/images/default.svg',
          'color': Colors.grey,
        };
  }

  static const List<String> wallets = [
    'CASH',
    'CREDIT',
    'DEBIT',
    'UPI',
  ];
}
