
class TrainingModuleModel{
  TrainingModuleModel({
    required this.module_id,
    required this.video_path,
    required this.module_description,
    required this.video_description,
    required this.question_list,
  });
  int? module_id;
  String video_path;
  String module_description;
  String video_description;
  List<dynamic> question_list;

}