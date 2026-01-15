import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Column(
          children: [
            // Close Button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Header Text
                    Text(
                      'How your free trial works',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You won\'t be charged anything today',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Timeline Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryDarker.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline visual
                          Column(
                            children: [
                              _TimelineIcon(icon: Icons.check_circle, active: true),
                              _TimelineLine(),
                              _TimelineIcon(icon: Icons.lock_open, active: false),
                              _TimelineLine(),
                              _TimelineIcon(icon: Icons.notifications_none, active: false),
                              _TimelineLine(),
                              _TimelineIcon(icon: Icons.star_border, active: false),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _TimelineItem(
                                  title: 'Install the app',
                                  description: 'Set it up to match your goals',
                                  isCompleted: true,
                                ),
                                const SizedBox(height: 32),
                                _TimelineItem(
                                  title: 'Today: get full access',
                                  description: 'Enjoy full access, totally free for your first 3 days',
                                ),
                                const SizedBox(height: 32),
                                _TimelineItem(
                                  title: '16 Jan - Trial reminder',
                                  description: 'To let you know it\'s ending soon',
                                ),
                                const SizedBox(height: 32),
                                _TimelineItem(
                                  title: '17 Jan - Become member',
                                  description: 'Your trial ends unless canceled',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Section (Button & Pricing)
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Reminder Toggle
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminder before trial ends',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Switch(
                          value: true,
                          onChanged: (val) {},
                          activeColor: AppTheme.primaryLight,
                          trackColor: MaterialStateProperty.resolveWith((states) => 
                            states.contains(MaterialState.selected) 
                              ? AppTheme.primaryDarker 
                              : null
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // CTA Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryLight, AppTheme.primaryMedium],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Start 3-day free trial',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Pricing Text
                  Text(
                    'TRY 149.99/month, billed yearly as\nTRY 1,799.99/year',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Footer Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FooterLink(text: 'Terms'),
                      _FooterLink(text: 'Restore purchase'),
                      _FooterLink(text: 'Other options'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineIcon extends StatelessWidget {
  final IconData icon;
  final bool active;

  const _TimelineIcon({required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: active ? AppTheme.primaryLight : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? Colors.transparent : Colors.white24,
          width: 2,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class _TimelineLine extends StatelessWidget {
  const _TimelineLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 40,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;

  const _TimelineItem({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.white54,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
