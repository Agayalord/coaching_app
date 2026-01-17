import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPrimaryTap,
    required this.onSkipTap,
    required this.showDots,
    required this.activeIndex,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSkipTap;
  final bool showDots;
  final int activeIndex; // 0,1,2

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SKIP chip (top-right), matches your mock
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: onSkipTap,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'SKIP',
                    style: TextStyle(letterSpacing: .5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Illustration
            Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            // Title (exact casing from your screenshots)
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 14),
            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(.72),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            if (showDots) _Dots(activeIndex: activeIndex),
            const SizedBox(height: 18),
            // Primary CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPrimaryTap,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF5A59C7), // your purple CTA
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  buttonText.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.activeIndex});
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    // 4 tiny dots in your mock, but only 3 slides; we’ll keep 3.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final bool active = i == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? Colors.black : Colors.black.withOpacity(.2),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
