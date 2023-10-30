import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacProvider extends ChangeNotifier {


  List<Widget> buttons = [];
  Set<int> buttonsIndexSet = <int>{};
  int counter = 0 ;

  List<List<String>>? board;
  String? currentPlayer;
  String? gameResult;
  String ? winnerPlayer ;

  String? x_current_time;
  String? o_current_time;


  TicTacProvider(){

    board = List.generate(3, (_) => List.generate(3, (_) => ''));
    currentPlayer = 'X';
    gameResult = '';

    notifyListeners();

  }

  HashMap<int,List<List<String>>?> myMap  =  HashMap<int,List<List<String>>?>();

  List<List<String>>? listOfmovies ;



  void fillCell(int row, int column, int index) {
    if (currentPlayer == 'X') {
      board![row][column] = 'X';
      myMap.putIfAbsent(index, () => deepCopy(board!));
      checkForWinner(row, column, currentPlayer!);
      currentPlayer = 'O';
    } else if (currentPlayer == 'O') {
      board![row][column] = 'O';
      myMap.putIfAbsent(index, () => deepCopy(board!)) ;
      checkForWinner(row, column, currentPlayer!);
      currentPlayer = 'X';
    }

    notifyListeners();
  }




  void checkForWinner(int? row, int? col, String player) {

    if (board![row!].every((cell) => cell == player)) {
       gameResult = player ;
       winnerPlayer= player;
    }

    if (board!.every((row) => row[col!] == player)) {
      gameResult = player;
      winnerPlayer = player;
    }

    if (row == col && board!.every((rows) => rows[row] == player)) {
      gameResult = player;
      winnerPlayer = player ;
    }

    if (row + col! == 2 && board!.every((rows) => rows[2 - row] == player)) {
      gameResult = player;
      winnerPlayer = player;
    }


    notifyListeners();
  }

  void go_to_speaficMovie(int index){
    board =  deepCopy(myMap[index]!);
    notifyListeners();

  }

  void addNewButton(int index) {

      if(!buttonsIndexSet.contains(index)) {
        buttonsIndexSet.add(index);
        counter++;
        buttons.add(
          ElevatedButton(
            onPressed: () {
              go_to_speaficMovie(index);
            },
            child: Text('go to move $counter'),
          ),
        );
      }


      print(myMap[index]);

      notifyListeners();



  }

  List<List<String>> deepCopy(List<List<String>> original) {
    List<List<String>> copy = List.generate(
      original.length,
          (row) => List.generate(original[row].length, (col) => original[row][col]),
    );
    return copy;
  }








}