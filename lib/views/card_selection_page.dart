import 'package:flutter/material.dart';

import 'board_page.dart';

class CardSelectionPage extends StatelessWidget {
  const CardSelectionPage(
      {super.key, required this.title, this.options = const [4, 6, 8, 10]});

  final List<int> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Wähle die Anzahl der Karten',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 18,
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 18),
                  children: options
                      .map((option) => TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightBlue),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.lightBlue)))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BoardPage(
                                      title: title, numberOfCards: option)),
                            );
                          },
                          child: Text(
                            '$option',
                            style: Theme.of(context).textTheme.headline5,
                          )))
                      .toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
