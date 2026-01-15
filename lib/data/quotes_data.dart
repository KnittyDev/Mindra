import '../models/quote.dart';

class QuotesData {
  static const List<Quote> quotes = [
    Quote(
      text: "Silence is the root of everything.",
      author: "Rumi",
      backgroundImage: "assets/images/forest_bg.png",
    ),
    Quote(
      text: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      backgroundImage: "assets/images/mountain_bg.png",
    ),
    Quote(
      text: "In the middle of difficulty lies opportunity.",
      author: "Albert Einstein",
      backgroundImage: "assets/images/ocean_bg.png",
    ),
    Quote(
      text: "Be yourself; everyone else is already taken.",
      author: "Oscar Wilde",
      backgroundImage: "assets/images/sunset_bg.png",
    ),
    Quote(
      text: "The journey of a thousand miles begins with one step.",
      author: "Lao Tzu",
      backgroundImage: "assets/images/path_bg.png",
    ),
  ];
}
