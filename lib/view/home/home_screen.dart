import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:cipherschool_assignment/custom_widgets/date_tab.dart';
import 'package:cipherschool_assignment/custom_widgets/income_expense_card.dart';
import 'package:cipherschool_assignment/custom_widgets/transaction_card.dart';
import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:cipherschool_assignment/navigation/custome_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;
  int _selectedIndex = 0;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;
  double accountBalance = 0.0;
  List<Map<String, dynamic>> recentTransactions = [];

  final List<String> _routes = [
    '/home',
    '',
    '/income',
    '',
    '/profile',
  ];

  void _onItemTapped(int index) {
    if (index == 1 || index == 3) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  final List<String> tabs = ["Today", "Week", "Month", "Year"];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var incomeBox = await Hive.openBox('incomeBox');
    var expenseBox = await Hive.openBox('expenseBox');

    double incomeSum = 0;
    double expenseSum = 0;
    List<Map<String, dynamic>> transactions = [];

    for (var income in incomeBox.values) {
      String timestamp = income['timestamp'] ?? '12:00 PM';
      incomeSum += income['amount'] as double;
      transactions.add(
        {
          'title': income['category'],
          'subtitle': income['description'],
          'amount': '+ ₹${income['amount'].toStringAsFixed(2)}',
          'time': _formatTime(timestamp),
          'color': const Color(0xff00A86B),
          'icon': 'assets/images/image.png',
        },
      );
    }

    for (var expense in expenseBox.values) {
      String timestamp = expense['timestamp'] ?? "12:00 PM";
      expenseSum += expense['amount'] as double;
      transactions.add({
        'title': expense['category'],
        'subtitle': expense['description'],
        'amount': '- ₹${expense['amount'].toStringAsFixed(2)}',
        'time': _formatTime(timestamp),
        'color': const Color(0xffFD3C4A),
        'icon': 'assets/images/expense.svg',
      });
    }

    setState(
      () {
        totalIncome = incomeSum;
        totalExpenses = expenseSum;
        accountBalance = totalIncome - totalExpenses;
        recentTransactions = transactions;
      },
    );
  }

  String _formatTime(String timestamp) {
    return timestamp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9FB),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFF6E5),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/images/image.png',
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(
              color: primaryColor.withOpacity(0.1),
              width: 1.w,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/images/arrow_down.svg",
                color: primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'March',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: SvgPicture.asset(
              'assets/images/notification.svg',
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffFFF6E5),
              const Color(0xffF8EDD8).withOpacity(0),
              const Color(0xffF9F9FB),
            ],
            stops: const [0.0, 0.5, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    'Account Balance',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '₹${accountBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncomeExpenseCard(
                    title: 'Income',
                    amount: '₹$totalIncome',
                    icon: 'assets/images/income.svg',
                    color: const Color(0xff00A86B),
                    secondaryTextColor: const Color(0xffFCFCFC),
                    onTap: () {
                      context.go(AppRouter.incomeRoute);
                    },
                  ),
                  IncomeExpenseCard(
                    title: 'Expenses',
                    amount: '₹$totalExpenses',
                    icon: 'assets/images/expense.svg',
                    color: const Color(0xffFD3C4A),
                    secondaryTextColor: const Color(0xffFCFCFC),
                    onTap: () {
                      context.go(AppRouter.expenseRoute);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  tabs.length,
                  (index) => DateTab(
                    text: tabs[index],
                    isSelected: index == selectedTabIndex,
                    onTap: () {
                      setState(
                        () {
                          selectedTabIndex = index;
                        },
                      );
                    },
                    selectedColor: const Color(0xffFCEED4),
                    unselectedColor: const Color(0xffFCAC12),
                    textColor: textColor,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffEEE5FF),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: const Color(0xff7F3DFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Column(
                children: recentTransactions
                    .map(
                      (transaction) => TransactionCard(
                        title: transaction['title'],
                        subtitle: transaction['subtitle'],
                        amount: transaction['amount'],
                        time: transaction['time'],
                        backgroundColor: transaction['color'],
                        textColor: transaction['color'],
                        iconPath: transaction['icon'],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
