import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project1/main_screen.dart';
import 'package:project1/hidden_widget.dart';
import 'package:word_search_safety/word_search_safety.dart';
import 'package:project1/models/game_state.dart';
import 'package:project1/database/word_list_database.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, required this.ner});
  final String ner;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List<bool> revealedhiddenWord = []; //hichneen ug taasan eseh
  late List<String> hiddenWord = []; //taah ug

  final WordSearchSafety wordSearch = WordSearchSafety();
  WSNewPuzzle? newPuzzle; //shine puzzle gargana
  WSSolved? solved; //nogoo hojoh tusam ihseh too

  final WSSettings settings = WSSettings(
      width: 7, height: 2, orientations: List.from([WSOrientation.horizontal]));

  late GameState gameState;
  int currentindex = 0; //heddeh taalt deer yavj bn ve
  bool isWon = false; //hojson eseh
  int howManyGuessed = 0; //hechneen taasan ve

  int life = 5;
  bool hintPress=false;

  @override
  void initState() {
    super.initState();
    final WordListRepository wordListRepository = WordListRepository();

    gameState = GameState(
      currentModel: wordListRepository.search_words[currentindex],
      currentModelindex: currentindex,
      isWon: isWon,
      howManyGuessed: howManyGuessed,
    );
    hiddenWord = gameState.currentModel.hiddenWord;
    revealedhiddenWord = List.filled(hiddenWord.length, false);
    newPuzzle = wordSearch.newPuzzle(hiddenWord.cast<String>(), settings);
    if (newPuzzle!.errors!.isEmpty) {
      solved = wordSearch.solvePuzzle(
          newPuzzle!.puzzle!, gameState.currentModel.hiddenWord);
    }
  }

  void onLetterSelected(String letter) {
    setState(() {
      updateHiddenWordGrid(letter);
    });
  }

  void updateHiddenWordGrid(letter) {
    print('updateHiddenWordGrid: $letter');
    for (int i = 0; i < hiddenWord.length; i++) {
      if (hiddenWord[i] == letter) {
        revealedhiddenWord[i] = true;
      }

    }
    if(!hiddenWord.contains(letter)){
      life--;
      if(life==0){
        showGameOverDialog();
      }
    }


    if (revealedhiddenWord.every((element) => element == true)) {
      print('You won!');
      isWon = true;
      currentindex++;
      howManyGuessed++;
      if (isWon) {
        if (WordListRepository().search_words.length - 1 ==
            gameState.currentModelindex) {
          print('You won the game!');
          showGameWinDialog();
          return;
        }
        gameState.currentModelindex++;
        gameState.currentModel =
            WordListRepository().search_words[gameState.currentModelindex];
        hiddenWord = gameState.currentModel.hiddenWord;
        revealedhiddenWord = List.filled(hiddenWord.length, false);
        isWon = false;
        newPuzzle = wordSearch.newPuzzle(hiddenWord.cast<String>(), settings);
      }
    }
  }

  void showGameOverDialog(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Game Over', style: TextStyle(
              fontFamily: 'Ribeye',
              fontSize: 30,
              color: Colors.orange
            ),),
            actionsAlignment: MainAxisAlignment.center,
            content: Text(
              'You lost. Game over', style: TextStyle(
              fontFamily: 'Ribeye',
                  fontSize: 20,
            ),
            ),
            actions: [
              TextButton(onPressed: (){
                resetGame();
                Navigator.pop(context);
              }, child: Text('RESTART'))
            ],
          );
        });
  }

  void showGameWinDialog(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('You won', style: TextStyle(
                fontFamily: 'Ribeye',
                fontSize: 30,
                color: Colors.orange
            ),),
            actionsAlignment: MainAxisAlignment.center,
            content: Text(
              'You win. Good job.', style: TextStyle(
              fontFamily: 'Ribeye',
              fontSize: 20,
            ),
            ),
            actions: [
              TextButton(onPressed: (){
                resetGame();
                Navigator.pop(context);
              }, child: Text('RESTART'))
            ],
          );
        });
  }


  void resetGame(){
    life =5;
    currentindex=0;
    isWon = false;

    final WordListRepository wordListRepository = WordListRepository();
    gameState = GameState(
      currentModel: wordListRepository.search_words[currentindex],
      currentModelindex: currentindex,
      isWon: isWon,
      howManyGuessed: howManyGuessed,
    );
    hiddenWord = gameState.currentModel.hiddenWord;
    revealedhiddenWord = List.filled(hiddenWord.length, false);
    newPuzzle = wordSearch.newPuzzle(hiddenWord.cast<String>(), settings);
    if (newPuzzle!.errors!.isEmpty) {
      solved = wordSearch.solvePuzzle(
          newPuzzle!.puzzle!, gameState.currentModel.hiddenWord);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/exit.png'),
        ),
        title: Text(
          widget.ner,
          style: const TextStyle(
              fontSize: 23, fontFamily: 'Ribeye', color: Colors.orange),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/trophy 1.png')),
          Text(
            '$howManyGuessed',
            style: const TextStyle(
                fontSize: 28, fontFamily: 'Ribeye', color: Colors.orange),
          )
        ],
        centerTitle: true,
      ),
      body: Stack(children: [
        Image.asset(
          'assets/back2.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  life>=1?Image.asset('assets/orange.png', scale:1.5):Image.asset('assets/orangeGray.png', scale:0.5),
                  life>=2?Image.asset('assets/orange.png', scale:1.5):Image.asset('assets/orangeGray.png', scale:0.5),
                  life>=3?Image.asset('assets/orange.png', scale:1.5):Image.asset('assets/orangeGray.png', scale:0.5),
                  life>=4?Image.asset('assets/orange.png', scale:1.5):Image.asset('assets/orangeGray.png', scale:0.5),
                  life==5?Image.asset('assets/orange.png', scale:1.5):Image.asset('assets/orangeGray.png', scale:0.5),

                ],
              ),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: []),
              Text('${currentindex + 1}/3'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: currentindex == 0
                        ? Image.asset('assets/previousGray.png')
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                currentindex--;
                                gameState.currentModelindex--;
                                gameState.currentModel =
                                WordListRepository().search_words[gameState.currentModelindex];
                                hiddenWord = gameState.currentModel.hiddenWord;
                                revealedhiddenWord = List.filled(hiddenWord.length, false);
                                isWon = false;
                                newPuzzle = wordSearch.newPuzzle(hiddenWord.cast<String>(), settings);
                              });

                            },
                            child: Image.asset('assets/previous 1.png')),
                  ),
                  Flexible(
                    flex: 6,
                    child: Image.asset(gameState.currentModel.imageURL),
                  ),
                  Flexible(
                      flex: 1,
                      child: currentindex == 2
                          ? Image.asset('assets/nextGray.png')
                          : GestureDetector(
                              child: Image.asset('assets/next.png'),
                              onTap: () {
                                setState(() {
                                  currentindex++;
                                  gameState.currentModelindex++;
                                  gameState.currentModel =
                                  WordListRepository().search_words[gameState.currentModelindex];
                                  hiddenWord = gameState.currentModel.hiddenWord;
                                  revealedhiddenWord = List.filled(hiddenWord.length, false);
                                  isWon = false;
                                  newPuzzle = wordSearch.newPuzzle(hiddenWord.cast<String>(), settings);
                                });

                              },
                            ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(hiddenWord.length, (index) {
                  if (revealedhiddenWord[index]) {
                    print(hiddenWord[index]);
                    return HiddenWidget(
                        letter: hiddenWord[index], height: 60, width: 60);
                  } else {
                    return const HiddenWidget(
                        letter: '', height: 60, width: 60);
                  }
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/hint.png',
                    scale: 3,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        hintPress = !hintPress;
                      });
                    },
                    child: Text(hintPress?'$hiddenWord':'HINT',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, -3))
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: settings.width,
                            ),
                            itemCount: settings.width * settings.height,
                            itemBuilder: (BuildContext context, int index) {
                              final int row = index ~/ settings.width;
                              final int col = index % settings.width;
                              final cell = newPuzzle!.puzzle![row][col];
                              return GestureDetector(
                                onTap: () {
                                  print('tapped $cell');
                                  onLetterSelected(cell);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 7, color: Colors.orange),

                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFE48000),
                                    // color: selectedLetter == cell ? Colors.blue : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    cell,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Ribeye',
                                        fontSize: 20),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
