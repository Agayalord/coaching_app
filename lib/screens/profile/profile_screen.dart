import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dailyReminders = true;

  void _onDeleteData() {
    // TODO: Hook this into real data deletion logic later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data deletion requested (demo only).'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F52B5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
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
              // ===================== User Info Card =====================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 18),
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
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 30,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name & email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amaka Johnson', // dummy name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'amaka.johnson@example.com', // dummy email
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ===================== Physical Data Section =====================
              const Text(
                'Physical Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'These values help Smart Coaching tailor your daily recommendations.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),

              _ReadOnlyFieldRow(
                label: 'Weight',
                value: '70 kg',
                onEditTap: () {
                  // TODO: later show dialog or navigate to edit
                },
              ),
              const SizedBox(height: 8),

              _ReadOnlyFieldRow(
                label: 'Height',
                value: '170 cm',
                onEditTap: () {
                  // TODO: later show dialog or navigate to edit
                },
              ),
              const SizedBox(height: 8),

              _ReadOnlyFieldRow(
                label: 'Goal',
                value: 'Lose weight',
                onEditTap: () {
                  // TODO: later show dialog or navigate to edit
                },
              ),

              const SizedBox(height: 24),

              // ===================== Notifications Section =====================
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Stay on track with gentle reminders throughout the day.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Daily reminders',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Receive daily notifications about your plan and progress.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                value: _dailyReminders,
                activeThumbColor: primaryColor,
                onChanged: (value) {
                  setState(() => _dailyReminders = value);
                },
              ),

              const SizedBox(height: 24),

              // ===================== Privacy Section =====================
              const Text(
                'Privacy & Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'You control your data.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'You can request deletion of your stored data at any time. '
                'In this demo version, this button only shows a confirmation message.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _onDeleteData,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'DELETE MY DATA',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===================== Feedback Button =====================
              const Text(
                'Help Us Improve',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your experience with Smart Coaching to support future improvements.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/feedback'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'GIVE FEEDBACK',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
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

// ======================= Helper Widget =======================

class _ReadOnlyFieldRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEditTap;

  const _ReadOnlyFieldRow({
    required this.label,
    required this.value,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Label & value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Edit button (no logic yet)
          TextButton(
            onPressed: onEditTap,
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
