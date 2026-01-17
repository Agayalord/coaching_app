import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F52B5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress & Insights'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===================== Weight Trend Card =====================
              _ProgressCard(
                title: 'Weight Trend (Last 7 Days)',
                legend:
                    'Demo data – lines represent approximate changes over the week.',
                child: _ChartPlaceholder(
                  label: 'Line chart placeholder',
                  gradientColors: [
                    primaryColor.withOpacity(0.25),
                    primaryColor.withOpacity(0.7),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ===================== Calories vs Target Card =====================
              _ProgressCard(
                title: 'Calories vs Target (Last 7 Days)',
                legend:
                    'Demo data – bars could represent calories consumed vs target per day.',
                child: _ChartPlaceholder(
                  label: 'Bar chart placeholder',
                  gradientColors: [
                    const Color(0xFF0B2F5B).withOpacity(0.2),
                    primaryColor.withOpacity(0.8),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ===================== Activity Minutes Card =====================
              _ProgressCard(
                title: 'Activity Minutes Per Day',
                legend:
                    'Demo data – visualising how active you have been each day.',
                child: _ChartPlaceholder(
                  label: 'Activity trend placeholder',
                  gradientColors: [
                    Colors.green.withOpacity(0.2),
                    Colors.green.withOpacity(0.7),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===================== Info Note =====================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.insights_outlined,
                      size: 20,
                      color: primaryColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'These graphs currently use static demo values. '
                        'In the full version, they will be populated with your real data over time.',
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================= Reusable Card Widget =======================

class _ProgressCard extends StatelessWidget {
  final String title;
  final String legend;
  final Widget child;

  const _ProgressCard({
    required this.title,
    required this.legend,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          // Legend
          Text(
            legend,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 14),
          // Chart placeholder
          child,
        ],
      ),
    );
  }
}

// ======================= Chart Placeholder Widget =======================

class _ChartPlaceholder extends StatelessWidget {
  final String label;
  final List<Color> gradientColors;

  const _ChartPlaceholder({required this.label, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Stack(
        children: [
          // Subtle diagonal stripes or overlay could be added later
          Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
