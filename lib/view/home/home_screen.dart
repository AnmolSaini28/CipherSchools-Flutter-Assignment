import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:cipherschool_assignment/custom_widgets/date_tab.dart';
import 'package:cipherschool_assignment/custom_widgets/income_expense_card.dart';
import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:cipherschool_assignment/navigation/custome_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;
  int _selectedIndex = 0;

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
    setState(
      () {
        _selectedIndex = index;
      },
    );
    context.go(_routes[index]);
  }

  final List<String> tabs = ["Today", "Week", "Month", "Year"];

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
                    '₹38000',
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
                    amount: '₹50000',
                    icon: 'assets/images/income.svg',
                    color: const Color(0xff00A86B),
                    secondaryTextColor: const Color(0xffFCFCFC),
                    onTap: () {
                      context.go(AppRouter.incomeRoute);
                    },
                  ),
                  IncomeExpenseCard(
                    title: 'Expenses',
                    amount: '₹12000',
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
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    selectedColor: const Color(0xffFCEED4),
                    unselectedColor: const Color(0xffFCAC12),
                    textColor: textColor,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    List<Map<String, dynamic>> transactions = [
      {
        "title": "Shopping",
        "subtitle": "Buy some grocery",
        "amount": "- ₹120",
        "time": "10:00 AM",
        "icon": "assets/images/shopping.svg",
        "color": const Color(0xffFFB800)
      },
      {
        "title": "Subscription",
        "subtitle": "Disney+ Annual..",
        "amount": "- ₹499",
        "time": "03:30 PM",
        "icon": "assets/images/subscription.svg",
        "color": const Color(0xff7F3DFF)
      },
      {
        "title": "Travel",
        "subtitle": "Chandigarh to De...",
        "amount": "- ₹1000",
        "time": "10:00 AM",
        "icon": "assets/images/travel.svg",
        "color": const Color(0xff00A86B)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTransactionHeader(),
        SizedBox(height: 16.h),
        ...transactions
            .map((transaction) => _buildTransactionCard(transaction)),
      ],
    );
  }

  Widget _buildTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Recent Transaction",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "See All",
          style: TextStyle(
            color: const Color(0xff7F3DFF),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: transaction['color'],
            radius: 24.r,
            child: SvgPicture.asset(
              transaction['icon'],
              height: 24.h,
              width: 24.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  transaction['subtitle'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                transaction['time'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
