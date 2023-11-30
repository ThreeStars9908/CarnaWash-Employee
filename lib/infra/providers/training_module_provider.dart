// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class TrainingModuleProvider with ChangeNotifier {
  final List<QuizQuestionModel> _trainingQuiz = [];

  List<QuizQuestionModel> get trainingQuiz => _trainingQuiz;

  Future<void> saveTrainingHistory(BuildContext context, int? module_id, int module_progress) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/skills/${module_id}/${module_progress}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      dynamic v = jsonDecode(response.body);
      if (response.statusCode == 200) {

      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Error',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! Update training progress',
        e.toString(),
      );
    }
  }

  Future<TrainingModuleModel?> loadTrainingModule(BuildContext context, int idx) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {

      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/training/modules/${idx}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      dynamic v = jsonDecode(response.body);
      print('eeee' + v.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        String moduleDescription = jsonData['description']['description'];
        int videoId = jsonData['videos']['id'];
        int moduleId = jsonData['videos']['module_id'];
        String videoPath = jsonData['videos']['path'];
        String videoDescription = jsonData['videos']['description'];
        List<dynamic> questions = jsonData['questions'];

        return TrainingModuleModel(module_id: moduleId, video_path: videoPath,
            module_description: moduleDescription, video_description: videoDescription, question_list: questions);
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Error',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! GetTrainingModule',
        e.toString(),
      );
    }
  }
}
