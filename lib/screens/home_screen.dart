import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../data/quotes_data.dart';
import '../widgets/quote_card.dart';
import '../widgets/action_buttons.dart';
import 'profile_screen.dart';
import 'premium_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for swipeable quotes
          PageView.builder(
            scrollDirection: Axis.vertical, // Vertical scrolling
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: QuotesData.quotes.length,
            itemBuilder: (context, index) {
              return QuoteCard(quote: QuotesData.quotes[index]);
            },
          ),
          // Action buttons at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ActionButtons(
              quote: QuotesData.quotes[_currentPage],
            ),
          ),
          // Page indicators (Vertical on the right)
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  QuotesData.quotes.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Top Navigation (Premium & Profile)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Premium Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.workspace_premium_outlined,
                          color: Colors.white,
                        ),
                        tooltip: 'Premium',
                      ),
                    ),
                    // Profile Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        tooltip: 'Profile',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
