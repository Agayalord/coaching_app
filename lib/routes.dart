import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/dashboard/home_screen.dart';
import 'screens/auth/account_setup_screen.dart'; // NEW
import 'screens/meals/log_meal_screen.dart';
import 'screens/activities/log_activity_screen.dart';
import 'screens/recommendations/recommendations_screen.dart';
import 'screens/progress/progress_screen.dart';
import 'screens/profile/profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/onboarding': (context) => const OnboardingScreen(),
  '/account-setup': (context) =>
      const AccountSetupScreen(), // NEW gateway after onboarding
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/home': (context) => const HomeScreen(),
  '/log-meal': (context) => const LogMealScreen(),
  '/log-activity': (context) => const LogActivityScreen(),
  '/recommendations': (context) => const RecommendationsScreen(),
  '/progress': (context) => const ProgressScreen(),
  '/profile': (context) => const ProfileScreen(),
  // '/lessons': (context) => const LessonsScreen(),
  // '/lessonDetail': (context) => const LessonDetailScreen(),
};
