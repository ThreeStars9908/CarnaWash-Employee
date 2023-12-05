// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class WasherProvider with ChangeNotifier {
  late BankInfoModel _bankInfo;
  late TimeAvailableProviderModel _timeAvailable;
  late WasherInfoModel _washerInfo;
  final List<QuizQuestionModel> _listQuizQuestions = [];
  late int _quizGrade;

  BankInfoModel get bankInfo => _bankInfo;
  TimeAvailableProviderModel get timeAvailable => _timeAvailable;
  WasherInfoModel get washerInfo => _washerInfo;
  List<QuizQuestionModel> get listQuizQuestions => _listQuizQuestions;
  int get quizGrade => _quizGrade;

  Future<void> fistLogin(
    BuildContext context,
    FirstLoginModel firstLoginModel,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.post(
          Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({
            "user_info": {
              "name" : firstLoginModel.user_info.name,
              "address": firstLoginModel.user_info.address,
              "phone" : firstLoginModel.user_info.phone,
            },
            "bank_info": {
              "bank_name": firstLoginModel.bank_info.bank_name,
              "account_name": firstLoginModel.bank_info.account_name,
              "account_number": firstLoginModel.bank_info.account_number,
            },
            "washer_info": {
              "abn": firstLoginModel.washer_info.abn,
              "contract": firstLoginModel.washer_info.contract,
              "driver_licence": firstLoginModel.washer_info.driver_licence,
              "picture": firstLoginModel.washer_info.picture,
            },
          }));


      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('First Login with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<int> verifyFistLogin(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/verify/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("ssss" + response.body);
        return v['message'];
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
        return 0;
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
      return 0;
    }
    return 0;
  }

  Future<void> loadQuiz(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/quiz/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);
      print('quiz list' + response.body);
      if (response.statusCode == 200) {
        for (Map i in v) {
          _listQuizQuestions.add(QuizQuestionModel(
            id: i['id'],
            question: i['question'],
            alternatives_list: i['alternatives_list'],
            answer: i['answer'],
          ));
        }
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> answerQuiz(
    BuildContext context,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.post(
          Uri.parse('${Constants.BACKEND_BASE_URL}/quiz/respon/'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({
            "grade": _quizGrade,
          }));

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('QuizAnswers sent with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  void loadQuizGrade(List list) {
    int points = 0;

    for (List i in list) {
      if (i[1] == 1) {
        points += 1;
      }
    }

    // _quizGrade = ((points / list.length) * 100).toInt();
    _quizGrade = 80;
    print('quizGrade' + _quizGrade.toString());
  }

  Future<void> updateContract(BuildContext context, ByteData contract) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.put(
          Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/info/'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({
            "contract": contract,
          }));

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Contract uploaded with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> loadBankInfo(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/bank/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _bankInfo = BankInfoModel(
          bank_name: v['bank_name'],
          account_name: v['account_name'],
          account_number: v['account_number'],
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> updateBankInfo(
      BuildContext context, BankInfoModel bankInfo) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/bank/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
        body: jsonEncode({
          "bank_name": bankInfo.bank_name,
          "account_name": bankInfo.account_name,
          "account_number": bankInfo.account_number,
        }),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Updated BankInfo with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
        await loadBankInfo(context);
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> loadTimeAvailable(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/time/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);
      print('time available' + response.body);
      if (response.statusCode == 200) {
        _timeAvailable = TimeAvailableProviderModel(
          saturday_list: v['saturday_list'],
          sunday_list: v['sunday_list'],
          monday_list: v['monday_list'],
          thursday_list: v['thursday_list'],
          tuesday_list: v['tuesday_list'],
          wednesday_list: v['wednesday_list'],
          friday_list: v['friday_list'],
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> updateTimeAvailable(
    BuildContext context,
    TimeAvailableProviderModel timeAvailable,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/time/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
        body: jsonEncode({
          "sunday_list": timeAvailable.sunday_list,
          "monday_list": timeAvailable.monday_list,
          "tuesday_list": timeAvailable.tuesday_list,
          "wednesday_list": timeAvailable.wednesday_list,
          "thursday_list": timeAvailable.thursday_list,
          "friday_list": timeAvailable.friday_list,
          "saturday_list": timeAvailable.saturday_list,
        }),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Updated TimeAvailable with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
        await loadTimeAvailable(context);
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  TimeAvailableModel getAllTimeAvailable() {
    return TimeAvailableModel(
      sunday_list: TimeAvailableChangeModel(
        day: 'Sunday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.sunday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.sunday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.sunday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.sunday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.sunday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.sunday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.sunday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.sunday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      monday_list: TimeAvailableChangeModel(
        day: 'Monday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.monday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.monday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.monday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.monday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.monday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.monday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.monday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.monday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      tuesday_list: TimeAvailableChangeModel(
        day: 'Tuesday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.tuesday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.tuesday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.tuesday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.tuesday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.tuesday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.tuesday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.tuesday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.tuesday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      wednesday_list: TimeAvailableChangeModel(
        day: 'Wednesday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.wednesday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.wednesday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.wednesday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.wednesday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.wednesday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.wednesday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.wednesday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.wednesday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      thursday_list: TimeAvailableChangeModel(
        day: 'Thrusday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.thursday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.thursday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.thursday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.thursday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.thursday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.thursday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.thursday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.thursday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      friday_list: TimeAvailableChangeModel(
        day: 'Friday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.friday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.friday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.friday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.friday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.friday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.friday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.friday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.friday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
      saturday_list: TimeAvailableChangeModel(
        day: 'Saturday',
        start: TimeOfDay(
          hour: int.parse(
            timeAvailable.saturday_list.split(';')[0].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.saturday_list.split(';')[0].split(':')[1],
          ),
        ),
        finish: TimeOfDay(
          hour: int.parse(
            timeAvailable.saturday_list.split(';')[1].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.saturday_list.split(';')[1].split(':')[1],
          ),
        ),
        breakpoint: TimeOfDay(
          hour: int.parse(
            timeAvailable.saturday_list.split(';')[2].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.saturday_list.split(';')[2].split(':')[1],
          ),
        ),
        pause: TimeOfDay(
          hour: int.parse(
            timeAvailable.saturday_list.split(';')[3].split(':')[0],
          ),
          minute: int.parse(
            timeAvailable.saturday_list.split(';')[3].split(':')[1],
          ),
        ),
      ),
    );
  }

  Future<void> loadWasherInfo(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/info/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );
      print('washer info'+ response.body);
      dynamic v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _washerInfo = WasherInfoModel(
          made_quiz: v['made_quiz'],
          contract_accept: v['contract_accept'],
          enable: v['enable'],
          rate: v['rate'].toDouble(),
          abn: v['abn'],
          contract: v['contract'],
          driver_licence: v['driver_licence'],
          picture: v['picture'],
        );
      } else if (v['errors'] != '') {
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }

  Future<void> updateWasherInfo(
      BuildContext context, WasherInfoModel washerInfo) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/washer/info/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
        body: jsonEncode({
          "abn": washerInfo.abn,
          "contract": washerInfo.contract,
          "driver_licence": washerInfo.driver_licence,
          "picture": washerInfo.picture,
        }),
      );

      var v = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Updated WasherInfo with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
        await loadWasherInfo(context);
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
      );
    }
  }
}
