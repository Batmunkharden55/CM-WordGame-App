import 'word_search_model.dart';

class GameState{
  WordSearchModel currentModel;
  int currentModelindex;
  bool isWon;
  int howManyGuessed;

  GameState({required this.currentModel, required this.currentModelindex, required this.howManyGuessed, required this.isWon});
}
