import 'package:flutter/material.dart';
import 'package:flutter_app1/provider/Words.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPage();
  }
}

class _AccountPage extends State<AccountPage> {
  Words _words;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    await _words.addWords();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 5));
    await _words.addWords();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Words>(builder: (context, words, child) {
        _words = words;
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(),
          footer: ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: words.length,
              itemBuilder: (context, i) {
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
              }),
        );
      }),
    );
  }
}
