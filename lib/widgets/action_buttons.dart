import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';

class ActionButtons extends StatefulWidget {
  final Quote quote;

  const ActionButtons({
    super.key,
    required this.quote,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Added to favorites',
            style: TextStyle(color: Colors.white, fontFamily: 'Playfair Display'),
          ),
          backgroundColor: const Color(0xFF134E4A), // App Theme Primary
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: const Color(0xFF2D7A6E), // Lighter Teal
            onPressed: () {
              setState(() {
                isFavorite = false;
              });
            },
          ),
        ),
      );
    }
  }

  void _shareQuote() {
    Share.share(
      '"${widget.quote.text}"\n\n— ${widget.quote.author}',
      subject: 'Motivational Quote',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Favorite button
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 32,
            ),
            color: isFavorite ? Colors.red.shade300 : Colors.white.withOpacity(0.9),
          ),
          const SizedBox(width: 48),
          // Share button
          IconButton(
            onPressed: _shareQuote,
            icon: const Icon(
              Icons.share_outlined,
              size: 32,
            ),
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}
