import 'card.dart';
import 'deck.dart';
import 'package:collection/collection.dart';

class Board {
  final Deck _deck;
  int matched = 0;
  int attempts = 0;

  Board(int numberOfCards) : _deck = Deck(numberOfCards) {
    _deck.shuffle();
  }

  List<Card> get cards {
    return _deck.cards;
    // .where((element) => !element.matched).toList();
  }

  bool get finished {
    return _deck.cards.every((element) => element.matched);
  }

  // restarts the game
  void restart() {
    matched = 0;
    attempts = 0;
    _deck.shuffle();
  }

  void select(Card card) {
    if (card.matched || card.faceUp) {
      return;
    }

    Iterable<Card> faceUpCards =
        _deck.cards.where((element) => !element.matched && element.faceUp);

    if (faceUpCards.isEmpty) {
      card.faceUp = true;
    } else if (faceUpCards.length == 1) {
      Card? faceUpCard = faceUpCards.firstOrNull;
      if (faceUpCard?.value == card.value) {
        card.matched = true;
        card.faceUp = true;
        faceUpCard?.matched = true;
        faceUpCard?.faceUp = true;
        matched++;
        attempts++;
      } else {
        card.faceUp = true;
      }
    } else if (faceUpCards.length == 2) {
      for (var element in faceUpCards) {
        element.faceUp = false;
      }
      card.faceUp = true;
      attempts++;
    }
  }
}
