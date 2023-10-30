

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xogame/screen/winnerscreen.dart';

import '../model/tictacmodel.dart';

class TicTacScreen extends StatefulWidget {
  const TicTacScreen({super.key});

  @override
  State<TicTacScreen> createState() => _TicTacScreenState();
}

class _TicTacScreenState extends State<TicTacScreen> {
  bool? isStarted = false ;
  String? o_formattedTime ;
  String? x_formattedTime;

  int buttonCount = 0;
  int  counter = 0 ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Duration duration = Duration(seconds:0);

    o_formattedTime = '${duration.inDays}:${duration.inMinutes}:${duration.inSeconds}';
    x_formattedTime = '${duration.inDays}:${duration.inMinutes}:${duration.inSeconds}';

  }


  @override

  @override
  Widget build(BuildContext context) {

    var tictacModel = context.watch<TicTacProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TicTacGame'
        ),
      ),
      body: tictacModel.gameResult?.isEmpty == true?  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Center(
          child: Column(

            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('X_time $x_formattedTime'),
                  Text("O_time $o_formattedTime"),
                ],
              ),
               Visibility(
                visible: true ,
                child: Text('Current Player : ${tictacModel.currentPlayer}' , style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
              const SizedBox(
                height: 20,
              ),

                 Expanded(
                   child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3
                      ),
                    itemCount: 9,
                    itemBuilder: (context ,index){

                        int row = index ~/ 3 ;
                        int columen = index %3 ;
                        final cellValue = tictacModel.board![row][columen];
                        return GestureDetector(

                             onTap: (){
                            if(isStarted!) {
                              tictacModel.fillCell(row, columen , index);
                              //tictacModel.checkForWinner(row, columen, tictacModel.currentPlayer!);
                              tictacModel.addNewButton(index);

                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration:   BoxDecoration(
                                color: Colors.white30,
                                border: Border.all(color :Colors.black)
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text(cellValue,
                                textAlign: TextAlign.center,

                                style: const TextStyle(fontSize: 24 )
                                ),
                              ),
                            ),
                          ),

                        );

                    },

                ),
                 ),
            tictacModel.buttons.isNotEmpty?  SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(children: tictacModel.buttons
                ,),
            ) : Row(),

              Container(
                width: double.infinity,
                color: Colors.blue,
                child: TextButton(
                    onPressed: (){
                      isStarted = true;
                      startTimer(context);
                    },
                    child: const Text('Start',
                    style: TextStyle(
                      color: Colors.white,
                    ),)),
              ),



            ],
          ),
        ),
      ) :  WinnerScreen(xtime: x_formattedTime, otime: o_formattedTime,),
    );
  }
  Duration durationx = Duration(seconds:0);
  Duration durationy = Duration(seconds:0);

  void startTimer(BuildContext context){

     var tictacModel = context.read<TicTacProvider>();


    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if(tictacModel.currentPlayer =='X' &&  tictacModel.gameResult?.isEmpty  == true) {
          durationx += const Duration(seconds: 1);
          x_formattedTime =
          "${durationx.inHours}:${durationx.inMinutes}:${durationx.inSeconds}";
          tictacModel.x_current_time = x_formattedTime;
        } else if( tictacModel.currentPlayer == 'O' &&  tictacModel.gameResult?.isEmpty  == true) {
          setState(() {
            durationy +=const Duration(seconds: 1);
            o_formattedTime = "${durationy.inHours}:${durationy.inMinutes}:${durationy.inSeconds}";
            tictacModel.o_current_time = o_formattedTime;
          });
        }
      });


    });
     }




  }




