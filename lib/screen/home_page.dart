import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:us_fitness_app/model/excercise_model.dart';
import 'package:us_fitness_app/screen/show_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  ExerciseModel exerciseModel = ExerciseModel();

  fetchExcersicesData() async {
    try {
      isLoading = true;
      var url =
          "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2dcq-xBH13wH4pKR7VYlEy3NMWcU9cL5ySVNtCyvY9YiTNNQI54x-kT-M";
      var responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        exerciseModel = ExerciseModel.fromJson(data);
        print("responce dataaaa areee ${data}");
        print("responce dataaaa areee ${exerciseModel.exercises!.length}");
        showInToast("Success");
        isLoading = false;
        setState(() {});
      } else {
        showInToast("Something wrong, try again");
        print("something wrong");
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      print("something wrong$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchExcersicesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: CircularProgressIndicator(),
        child: exerciseModel.exercises != null
            ? Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                          "Total Length is ${exerciseModel.exercises!.length}"),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: exerciseModel.exercises!.length,
                          itemBuilder: (context, index) {
                            var data = exerciseModel.exercises![index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ShowDetailsScreen(exercises: data)));
                              },
                              child: Container(
                                color: Colors.red,
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  children: [
                                    Image.network(
                                      "${data.thumbnail}",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 140,
                                    ),
                                    Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        "${data.title}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 32),
                                      )),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                            Colors.black,
                                            Colors.black54,
                                            Colors.black54,
                                            Colors.black12,
                                          ])),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}

showInToast(String title) {
  return Fluttertoast.showToast(
      msg: "$title",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
