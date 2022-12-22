class Card {
  int id;
  bool faceUp;
  bool matched;

  String get value {
    return '$id';
  }

  Card(this.id, this.faceUp, this.matched);
}
