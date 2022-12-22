import 'package:flutter/material.dart';
import '../models/board.dart';
import '../models/card.dart' as game_card;

class BoardPage extends StatefulWidget {
  const BoardPage(
      {super.key, required this.title, required this.numberOfCards});

  final String title;
  final int numberOfCards;

  @override
  State<BoardPage> createState() => _BoardPageState(numberOfCards);
}

class _BoardPageState extends State<BoardPage> {
  final List<Color> colors = [
    Colors.lightBlue,
    Colors.red,
    Colors.amber,
    Colors.brown,
    Colors.greenAccent,
    Colors.deepPurple,
    Colors.orange
  ];
  final List<AssetImage> icons = [
    const AssetImage('images/cards/bird.png'),
    const AssetImage('images/cards/cow.png'),
    const AssetImage('images/cards/elephant.png'),
    const AssetImage('images/cards/frog.png'),
    const AssetImage('images/cards/kangaroo.png'),
    const AssetImage('images/cards/lion.png')
  ];
  final Board _board;

  _BoardPageState(int numberOfCards) : _board = Board(numberOfCards);

  void _restart() {
    setState(() {
      _board.restart();
    });
  }

  void _onCard(game_card.Card card) {
    setState(() {
      _board.select(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_board.finished ? 'Fertig!' : widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  crossAxisCount: _board.cards.length / 2 >= 3 ? 3 : 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 24,
                  childAspectRatio: 6 / 7,
                  children:
                      _board.cards.map((card) => cardWidget(card)).toList(),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: footerWidget())
            ]),
      ),
    );
  }

  Widget cardWidget(game_card.Card card) {
    return card.faceUp ? faceUpCardWidget(card) : faceDownCardWidget(card);
  }

  Widget faceUpCardWidget(game_card.Card card) {
    Color cardColor = colors[card.id % colors.length];
    AssetImage cardIcon = icons[card.id % icons.length];
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(cardColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: cardColor)))),
      onPressed: () {
        _onCard(card);
      },
      child: Image(image: cardIcon),
      // Text(
      //   card.value,
      //   style: Theme.of(context).textTheme.headline5,
      // ),
    );
  }

  Widget faceDownCardWidget(game_card.Card card) {
    return GestureDetector(
      onTap: () {
        _onCard(card);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: const Image(
            image: AssetImage('images/card_back.png'), fit: BoxFit.fill),
      ),
    );
  }

  Widget footerWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paare: ${_board.matched}',
                style: Theme.of(context).textTheme.headlineSmall),
            Text('Versuche: ${_board.attempts}',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[300],
          child: IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _restart();
              });
            },
          ),
        )
      ],
    );
  }
}
