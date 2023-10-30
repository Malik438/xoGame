
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/tictacmodel.dart';

class WinnerScreen extends StatefulWidget {
  final String? xtime ;
  final String? otime ;
  const WinnerScreen({super.key, this.xtime, this.otime});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  String? totalTime ;


  @override
  void initState() {
    // TODO: implement initState

    formatTotalTime(widget.xtime!, widget.otime!);

  }

  @override
  Widget build(BuildContext context) {

    var tactacModel = context.watch<TicTacProvider>();
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: [
            const Text("the Winner is " ,
              style: TextStyle(
                fontSize:  20.0,
                fontWeight: FontWeight.bold,
              ) ,),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                color: Colors.grey,
                width: 200,
                height: 200,
                child: Center(child: Text(tactacModel.winnerPlayer!,
                style: const TextStyle(
                  fontSize: 100.0
                ),)),
              ),
            ),
            Text("X took : ${tactacModel.x_current_time} ",
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),) ,
            Text("O took : ${tactacModel.o_current_time} ",
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            Text("Total Time : $totalTime  ",
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            Text("Number of moves : ${tactacModel.myMap.length}",
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),



          ],
        ),
      ),
    );
  }

  void formatTotalTime(String xtime , String otime){
    List<int> parts1 = xtime.split(':').map(int.parse).toList();
    List<int> parts2 = otime.split(':').map(int.parse).toList();

    int totalSeconds = (parts1[0] + parts2[0]) * 3600 + (parts1[1] + parts2[1]) * 60 + (parts1[2] + parts2[2]);

    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

     totalTime = "$hours:$minutes:$seconds";
  }

}
