import 'package:flutter/material.dart';
import 'onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  void _toLogin() => Navigator.pushReplacementNamed(context, '/login');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = [
      (
        img: 'assets/onboarding1.png',
        title: 'Personalised Coaching For Busy Lives',
        sub:
            'Smart Coaching Adapts To Your Schedule And Goals. Get Daily Fitness And Nutrition Plans Designed Uniquely For You.',
      ),
      (
        img: 'assets/onboarding2.png',
        title: 'Stay Motivated With Real Insights',
        sub:
            'Track Your Performance With AI-Powered Feedback. See Your Improvements, Hit Targets, And Push Beyond Your Limits.',
      ),
      (
        img: 'assets/onboarding3.png',
        title: 'Build Healthy Habits That Last',
        sub:
            'Start Simple, Stay Consistent. Smart Coaching Guides Your Journey—One Meal, One Step, One Success At A Time.',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (i) => setState(() => _index = i),
        itemCount: slides.length,
        itemBuilder: (_, i) => OnboardingSlide(
          imagePath: slides[i].img,
          title: slides[i].title,
          subtitle: slides[i].sub,
          buttonText: i == slides.length - 1 ? 'Continue' : 'Next',
          activeIndex: _index,
          showDots: true,
          onSkipTap: _toLogin,
          onPrimaryTap: () {
            if (_index < slides.length - 1) {
              _controller.nextPage(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOut,
              );
            } else {
              _toLogin();
            }
          },
        ),
      ),
    );
  }
}
