import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/provider/Words.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPage();
  }
}

class _AccountPage extends State<AccountPage> {
  var _words;

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      _words.addWords();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            child: Consumer<Words>(
              builder: (context, words, child) {
                _words = words;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: words.length,
                  itemBuilder: /*1*/ (context, i) {
                    if (i.isOdd) return Divider();
                    final index = i ~/ 2;
                    var currentWords = words.getTotal()[index];
                    final bool alreadySaved =
                        words.getSaved().contains(currentWords);
                    return ListTile(
                      title: Text(
                        currentWords.asPascalCase,
                      ),
                      trailing: Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : null,
                      ),
                      onTap: () {
                        alreadySaved == true
                            ? words.removeFavoriteWord(currentWords)
                            : words.addFavoriteWord(currentWords);
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Warming"),
                                content: Text("are you want to del this item?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Icon(Icons.delete_forever),
                                    onPressed: () {
                                      Navigator.of(context).pop(1);
                                      words.delWords(currentWords);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  },
                );
              },
            ),
            onRefresh: _onRefresh));
  }
}
