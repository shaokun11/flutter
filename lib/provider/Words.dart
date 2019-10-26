import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

class Words extends ChangeNotifier {
  var _totalWords = [];
  var _savedWords = new Set<WordPair>();
  bool _add = false;

  getTotal() {
    return _totalWords;
  }

  getSaved() {
    return _savedWords;
  }

  delWords(WordPair wordPair){
    if(_savedWords.contains(wordPair)) {
      _savedWords.remove(wordPair);
    }
    if(_totalWords.contains(wordPair)) {
      _totalWords.remove(wordPair);
    }
    notifyListeners();
  }

  addWords() {
    if (_add) return ;
    _add = true;
    _totalWords.addAll(generateWordPairs().take(100));
  }

  addFavoriteWord(WordPair wordPair) {
    _savedWords.add(wordPair);
    notifyListeners();
  }

  removeFavoriteWord(WordPair wordPair) {
    _savedWords.remove(wordPair);
    notifyListeners();
  }
}
