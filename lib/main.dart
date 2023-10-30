import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xogame/model/tictacmodel.dart';
import 'package:xogame/screen/tictacscreen.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => TicTacProvider(),
        child: const TicTacScreen(),
      ),
    );
  }
}



