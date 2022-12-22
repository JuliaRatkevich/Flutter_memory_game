import 'card.dart';

class Deck {
  List<Card> cards;

  Deck(int numberOfCards)
      : cards = List.generate(
            numberOfCards, (index) => Card(index ~/ 2 + 1, false, false));

  // shuffles cards
  void shuffle() {
    for (var card in cards) {
      {
        card.faceUp = false;
        card.matched = false;
      }
    }
    cards.shuffle();
  }
}
