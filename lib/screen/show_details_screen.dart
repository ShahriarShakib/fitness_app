import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:us_fitness_app/model/excercise_model.dart';
import 'package:us_fitness_app/screen/display_video.dart';


class ShowDetailsScreen extends StatefulWidget {
  Exercises exercises;
    ShowDetailsScreen({Key? key,required this.exercises}) : super(key: key);

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {

  int? selectedTime=5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.network("${widget.exercises.thumbnail}",height: double.infinity,fit: BoxFit.cover,)
         ,Positioned(
                bottom: 20,
                left: 0,right: 0,
                child: Column(
                  children: [
                  SleekCircularSlider(
                  min: 3,
                  max: 15,
                  initialValue: 5,
                  onChange: (double value) {
                    setState(() {
                      selectedTime=value.toInt();

                    });
                    // callback providing a value while its being changed (with a pan gesture)
                  },
                  onChangeStart: (double startValue) {
                    // callback providing a starting value (when a pan gesture starts)
                  },
                  onChangeEnd: (double endValue) {
                    // ucallback providing an ending value (when a pan gesture ends)
                  },
                  innerWidget: (double ?value) {
                     return Container(
                       alignment: Alignment.center,
                       child: Text("${value!.toInt()}",style: TextStyle(
                         fontSize: 25,
                       ),),
                     );
                    // use your custom widget inside the slider (gets a slider value from the callback)
                  },
                ),

                    MaterialButton(
                      color: Colors.teal,
                      height: 50,minWidth: 80,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            DisplayVideo(exercises: widget.exercises, selectedTime: selectedTime!)));
                      },
                    child: Text("Go"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
