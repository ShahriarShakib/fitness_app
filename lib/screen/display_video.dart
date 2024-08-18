import 'dart:async';

import 'package:flutter/material.dart';
import 'package:us_fitness_app/model/excercise_model.dart';

class DisplayVideo extends StatefulWidget {
    DisplayVideo({Key? key,required this.exercises,required this.selectedTime}) : super(key: key);
  Exercises exercises;
  int selectedTime;

  @override
  State<DisplayVideo> createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {

  int chooseTime=0;
  Timer ?timer;

  @override
  void initState() {
    // TODO: implement initState
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(timer.tick>widget.selectedTime){
        timer.cancel();
        Navigator.pop(context);
      }else{
        chooseTime=timer.tick;
        setState(() {

        });
      }

    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Image.network("${widget.exercises.gif}"),
            Text("Time Remain ${widget.selectedTime}/${chooseTime} ")
          ],
        ),
      ),

    );
  }
}
