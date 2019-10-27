import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

class Words extends ChangeNotifier {
  var _totalWords = [];
  var _savedWords = new Set<WordPair>();

  int get length => _totalWords.length;

  getTotal() {
    return _totalWords;
  }

  getSaved() {
    return _savedWords;
  }

  delWords(WordPair wordPair) {
    if (_savedWords.contains(wordPair)) {
      _savedWords.remove(wordPair);
    }
    if (_totalWords.contains(wordPair)) {
      _totalWords.remove(wordPair);
    }
    notifyListeners();
  }

  addWords() {
    _totalWords.addAll(generateWordPairs().take(20));
    notifyListeners();
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
