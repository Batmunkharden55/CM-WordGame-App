import 'package:project1/models/word_search_model.dart';

class WordListRepository{
  final List<WordSearchModel> search_words = [
    WordSearchModel(
        imageURL: 'assets/IMG.png',
        hiddenWord: ['M','I','C','K','E','Y']),
    WordSearchModel(
        imageURL: 'assets/elsa.png',
        hiddenWord: ['E', 'L', 'S', 'A']),
    WordSearchModel(
        imageURL: 'assets/totoro.jpeg',
        hiddenWord: ['T', 'O', 'T', 'O', 'R', 'O']),
  ];
}
