import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../data/quotes_data.dart';
import '../managers/theme_manager.dart';
import '../services/notification_service.dart';
import 'themes_screen.dart';
import 'favorites_screen.dart';
import 'notification_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontFamily: 'Playfair Display',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Guest User',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Playfair Display',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Moods Section

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _MoodCard(icon: Icons.wb_sunny_outlined, label: 'Happy'),
                  SizedBox(width: 16),
                  _MoodCard(icon: Icons.nightlight_outlined, label: 'Calm'),
                  SizedBox(width: 16),
                  _MoodCard(icon: Icons.waves, label: 'Focus'),
                  SizedBox(width: 16),
                  _MoodCard(icon: Icons.cloud_outlined, label: 'Sad'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Themes Section

            _SettingsTile(
              icon: Icons.palette_outlined,
              title: 'Themes & Backgrounds',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThemesScreen()),
                );
              },
            ),

            const SizedBox(height: 16),

            // Favorites Section

            _SettingsTile(
              icon: Icons.favorite_border,
              title: 'Your Favorites',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                );
              },
            ),
            
            const SizedBox(height: 16),


            _SettingsTile(
              icon: Icons.notifications_active_outlined,
              title: 'Test Notification',
              onTap: () {
                NotificationService().showInstantNotification();
              },
            ),
            const SizedBox(height: 16),
            _SettingsTile(
              icon: Icons.timer_outlined,
              title: 'Daily Frequency',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            const _SettingsTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
            ),
            const SizedBox(height: 8),
            const _SettingsTile(
              icon: Icons.star_outline,
              title: 'Rate Us',
            ),
            const SizedBox(height: 8),
            const _SettingsTile(
              icon: Icons.chat_bubble_outline,
              title: 'Give Feedback',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white70, size: 24),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Playfair Display',
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MoodCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}


