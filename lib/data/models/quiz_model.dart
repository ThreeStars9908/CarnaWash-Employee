// ignore_for_file: non_constant_identifier_names

class QuizQuestionModel {
  QuizQuestionModel({
    this.id,
    required this.question,
    required this.answer,
    required this.alternatives_list,
  });

  int? id;
  String question;
  String answer;
  String alternatives_list;
}
