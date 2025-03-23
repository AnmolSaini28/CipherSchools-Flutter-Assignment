import 'package:cipherschool_assignment/authentication/signup_screen.dart';
import 'package:cipherschool_assignment/custom_widgets/income_expense_dialog.dart';
import 'package:cipherschool_assignment/onboarding/onboarding_screen.dart';
import 'package:cipherschool_assignment/onboarding/splash_screen.dart';
import 'package:cipherschool_assignment/view/acccount/account_screen.dart';
import 'package:cipherschool_assignment/view/expense/expense_screen.dart';
import 'package:cipherschool_assignment/view/home/home_screen.dart';
import 'package:cipherschool_assignment/view/income/income_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String signUpRoute = '/signUp';
  static const String onboardingRoute = '/onboarding';
  static const String homeRoute = '/home';
  static const String expenseRoute = '/expense';
  static const String incomeRoute = '/income';
  static const String profileRoute = '/profile';
  static const String dialogRoute = '/dialog';

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: expenseRoute,
        builder: (context, state) => const ExpenseScreen(),
      ),
      GoRoute(
        path: incomeRoute,
        builder: (context, state) => const IncomeScreen(),
      ),
      GoRoute(
        path: profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: dialogRoute,
        builder: (context, state) => const IncomeExpenseDialog(),
      ),
    ],
  );
}
