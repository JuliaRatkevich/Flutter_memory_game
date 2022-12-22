import 'dart:math';

import 'package:appp/models/board.dart';
import 'package:test/test.dart';

void main() {
  test('Finished should be true when all cards matched', () {
    final board = Board(10);

    expect(board.finished, false);

    board.cards.skip(1).forEach((element) {
      element.matched = true;
    });
    expect(board.finished, false);

    board.cards.first.matched = true;
    expect(board.finished, true);
  });

  test('Restart should reset counters to zero', () {
    final board = Board(10);

    board.attempts = 10;
    board.matched = 4;

    board.restart();

    expect(board.attempts, 0);
    expect(board.matched, 0);
  });

  test('Restart should turn cards face down', () {
    final board = Board(10);
    for (var element in board.cards) {
      element.faceUp = true;
    }

    board.restart();

    expect(board.cards.every((element) => element.faceUp == false), true);
  });

  test('Selecting matched card does nothing', () {
    final board = Board(10);
    final card = board.cards.first;
    card.matched = true;

    board.select(card);

    expect(card.matched, true);
  });

  test('Selecting faceUp card does nothing', () {
    final board = Board(10);
    final card = board.cards.first;
    card.faceUp = true;

    board.select(card);

    expect(card.faceUp, true);
  });

  test('Selecting first card makes it faceUp', () {
    final board = Board(10);
    final card = board.cards.first;

    board.select(card);

    expect(card.faceUp, true);
  });

  test('Selecting second card that doesn\'t match makes it faceUp', () {
    final board = Board(10);
    final card = board.cards.first;
    board.select(card);

    final anotherCard =
        board.cards.firstWhere((element) => element.value != card.value);
    board.select(anotherCard);

    expect(anotherCard.faceUp, true);
  });

  test('Selecting second card that matches updates counters', () {
    final board = Board(10);
    final card = board.cards.first;
    board.select(card);

    final anotherCard =
        board.cards.lastWhere((element) => element.value == card.value);
    board.select(anotherCard);

    expect(board.matched, 1);
    expect(board.attempts, 1);
  });

  test('Selecting second card that matches updates matched flag', () {
    final board = Board(10);
    final card = board.cards.first;
    board.select(card);

    final anotherCard =
        board.cards.lastWhere((element) => element.value == card.value);
    board.select(anotherCard);

    expect(anotherCard.matched, true);
    expect(card.matched, true);
    expect(anotherCard.faceUp, true);
    expect(card.faceUp, true);
  });

  test(
      'Selecting a card after wrong pair updates attempts count and keeps pair count',
      () {
    final board = Board(10);
    final card = board.cards.first;
    board.select(card);

    final anotherCard =
        board.cards.firstWhere((element) => element.value != card.value);
    board.select(anotherCard);

    final thirdCard = board.cards.last;
    board.select(thirdCard);

    expect(board.attempts, 1);
    expect(board.matched, 0);
  });

  test('Selecting a card after wrong pair facing them down', () {
    final board = Board(10);
    final card = board.cards.first;
    board.select(card);

    final anotherCard =
        board.cards.firstWhere((element) => element.value != card.value);
    board.select(anotherCard);

    final thirdCard = board.cards.last;
    board.select(thirdCard);

    expect(card.faceUp, false);
    expect(anotherCard.faceUp, false);
    expect(thirdCard.faceUp, true);
  });
}
