class ExerciseModel {
  List<Exercises>? exercises;

  ExerciseModel({this.exercises});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    if (json['exercises'] != null) {
      exercises = <Exercises>[];
      json['exercises'].forEach((v) {
        exercises!.add(new Exercises.fromJson(v));
      });
    }
  }


}

class Exercises {
  String? id;
  String? title;
  String? thumbnail;
  String? gif;
  String? seconds;

  Exercises({this.id, this.title, this.thumbnail, this.gif, this.seconds});

  Exercises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    gif = json['gif'];
    seconds = json['seconds'];
  }


}
