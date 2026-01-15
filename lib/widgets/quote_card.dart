import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../managers/theme_manager.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: ThemeManager.instance.currentBackgroundImageNotifier,
      builder: (context, globalBg, child) {
        // Use global theme if set, otherwise use quote's own background
        final backgroundImage = globalBg ?? quote.backgroundImage;
        
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(backgroundImage),
                width: 1080, // Limit memory usage while maintaining quality
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },
      child: Container(
        // Gradient overlay for text readability
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // Quote text
                Text(
                  '"${quote.text}"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 24),
                // Author
                Text(
                  '— ${quote.author}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 48),
                // CALM button
                OutlinedButton(
                  onPressed: () {
                    // TODO: Add calm/meditation functionality
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'CALM',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ), // Reusing the child content
    );
  }
}
