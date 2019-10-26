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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Words>(
        builder: (context, words, child) {
          words.addWords();
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, i) {
              if (i.isOdd) return Divider();
              final index = i ~/ 2;
              var currentWords = words.getTotal()[index];
              final bool alreadySaved = words.getSaved().contains(currentWords);
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
                onLongPress: (){
                  words.delWords(currentWords);
                },
              );
            },
          );
        },
      ),
    );
  }


}
