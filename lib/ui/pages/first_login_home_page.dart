// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:app_employee/data/data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infra/infra.dart';
import '../ui.dart';

class FirstLoginHomePage extends StatefulWidget {
  int? verify;
  FirstLoginHomePage({super.key, this.verify});

  @override
  State<FirstLoginHomePage> createState() => _FirstLoginHomePageState();
}

class _FirstLoginHomePageState extends State<FirstLoginHomePage> {
  int n = 1;
  int questionValue = 0;
  bool oneTrue = true;
  bool twoTrue = false;
  bool threeTrue = false;
  TextEditingController insuranceController = TextEditingController();

  List questionList = [];

  List isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  late TimeAvailableModel timeAvailable;

  void _selectTime(oldTime) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: oldTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        oldTime = newTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('first login ---');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      WasherProvider washerProvider = Provider.of(
        context,
        listen: false,
      );
      await washerProvider.loadTimeAvailable(context);
      timeAvailable = washerProvider.getAllTimeAvailable();
      print('first login --');
      await washerProvider.loadQuiz(context);

      for (QuizQuestionModel i in washerProvider.listQuizQuestions) {
        questionList.add([i, 0]);
      }
      setState(() {});
    });
    if (widget.verify! == 1) {
      n = 2;
    }
    setState(() {});
  }

  // CHANGE DOC TO BLOB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: (n == 2 ||
              n == 4 ||
              n == 6 ||
              n == 10 ||
              (n == 3 && !(questionValue < questionList.length / 4)))
          ? Center(
              child: geralComponent(context),
            )
          : SingleChildScrollView(
              child: geralComponent(context),
            ),
    );
  }

  Column geralComponent(BuildContext context) {
    WasherProvider washerProvider = Provider.of(context, listen: false);

    return Column(
      children: [
        n == 1
            ? partOne(context)
            : n == 2
                ? partTwo(context)
                : n == 3
                    ? partThree(context)
                    : n == 4
                        ? partFour(context)
                        : n == 5
                            ? partFive(context)
                            : n == 10
                                ? partFourHalf(context)
                                : partSix(context),
        if (n == 2 ||
            n == 4 ||
            n == 6 ||
            n == 10 ||
            n == 3 && !(questionValue< questionList.length / 4))
          Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50)),
            onPressed: () async {
              if (n == 1) {
                setState(() {
                  n = 2;
                });
              } else if (n == 2) {
                setState(() {
                  n = 3;
                });
              } else if (n == 3) {
                setState(() {
                  if (questionValue < questionList.length / 4) {
                    questionValue ++;
                  } else {
                    n = 4;
                    setState(() {
                      washerProvider.loadQuizGrade(questionList);
                    });
                    setState(() async{
                      await washerProvider.answerQuiz(context);
                    });

                  }
                });
              } else if (n == 4) {
                setState(() {
                  n = 10;
                  oneTrue = false;
                  twoTrue = true;
                  threeTrue = false;
                });
              } else if (n == 10) {
                setState(() {
                  n = 5;
                  oneTrue = false;
                  twoTrue = false;
                  threeTrue = true;
                  //
                });
              } else if (n == 5) {
                setState(() {
                  n = 6;
                });
              } else if (n == 6) {
                await washerProvider.updateTimeAvailable(
                  context,
                  TimeAvailableProviderModel(
                    sunday_list:
                        '${timeAvailable.sunday_list.start.hour}:${timeAvailable.sunday_list.start.minute};${timeAvailable.sunday_list.finish.hour}:${timeAvailable.sunday_list.finish.minute};${timeAvailable.sunday_list.breakpoint.hour}:${timeAvailable.sunday_list.breakpoint.minute};${timeAvailable.sunday_list.pause.hour}:${timeAvailable.sunday_list.pause.minute};',
                    monday_list:
                        '${timeAvailable.monday_list.start.hour}:${timeAvailable.monday_list.start.minute};${timeAvailable.monday_list.finish.hour}:${timeAvailable.monday_list.finish.minute};${timeAvailable.monday_list.breakpoint.hour}:${timeAvailable.monday_list.breakpoint.minute};${timeAvailable.monday_list.pause.hour}:${timeAvailable.monday_list.pause.minute};',
                    tuesday_list:
                        '${timeAvailable.tuesday_list.start.hour}:${timeAvailable.tuesday_list.start.minute};${timeAvailable.tuesday_list.finish.hour}:${timeAvailable.tuesday_list.finish.minute};${timeAvailable.tuesday_list.breakpoint.hour}:${timeAvailable.tuesday_list.breakpoint.minute};${timeAvailable.tuesday_list.pause.hour}:${timeAvailable.tuesday_list.pause.minute};',
                    wednesday_list:
                        '${timeAvailable.wednesday_list.start.hour}:${timeAvailable.wednesday_list.start.minute};${timeAvailable.wednesday_list.finish.hour}:${timeAvailable.wednesday_list.finish.minute};${timeAvailable.wednesday_list.breakpoint.hour}:${timeAvailable.wednesday_list.breakpoint.minute};${timeAvailable.wednesday_list.pause.hour}:${timeAvailable.wednesday_list.pause.minute};',
                    thursday_list:
                        '${timeAvailable.thursday_list.start.hour}:${timeAvailable.thursday_list.start.minute};${timeAvailable.thursday_list.finish.hour}:${timeAvailable.thursday_list.finish.minute};${timeAvailable.thursday_list.breakpoint.hour}:${timeAvailable.thursday_list.breakpoint.minute};${timeAvailable.thursday_list.pause.hour}:${timeAvailable.thursday_list.pause.minute};',
                    friday_list:
                        '${timeAvailable.friday_list.start.hour}:${timeAvailable.friday_list.start.minute};${timeAvailable.friday_list.finish.hour}:${timeAvailable.friday_list.finish.minute};${timeAvailable.friday_list.breakpoint.hour}:${timeAvailable.friday_list.breakpoint.minute};${timeAvailable.friday_list.pause.hour}:${timeAvailable.friday_list.pause.minute};',
                    saturday_list:
                        '${timeAvailable.saturday_list.start.hour}:${timeAvailable.saturday_list.start.minute};${timeAvailable.saturday_list.finish.hour}:${timeAvailable.saturday_list.finish.minute};${timeAvailable.saturday_list.breakpoint.hour}:${timeAvailable.saturday_list.breakpoint.minute};${timeAvailable.saturday_list.pause.hour}:${timeAvailable.saturday_list.pause.minute};',
                  ),
                );
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(validate: false),
                    ),
                  );
                });
              }
            },
            child: Text(n == 6
                ? 'Go to Home'
                : n == 5
                    ? 'Confirm'
                    : (n == 4 || n == 10)
                        ? 'Next Step'
                        : n == 1
                            ? 'Next'
                            : n == 2
                                ? 'Go to Quiz'
                                : (questionValue <
                                            questionList.length / 4 &&
                                        n == 3)
                                    ? 'Next'
                                    : 'Send your Answers'),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Logout",
            style: TextStyle(
              color: Color.fromRGBO(237, 189, 58, 1),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget partOne(BuildContext context) {
    UserProvider userProvider = Provider.of(context);

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        notificationHomeButtonComponent(context),
                        Text(
                          'Welcome, ${userProvider.perfil.name}!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Image(
                      width: 125,
                      image: AssetImage('images/logo.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thank you for applying to join the Carnawash team! You are only a few steps away from becoming your own boss, it's a great achievement!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Please find some easier and faster the following steps to start working with Carnawash!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Attended Carnawash Induction Day.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "2. Watch our short video to complete our quiz assessment required by clicking on the bottom below Let's start.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Finalize the registration process by providing your information and confirming your availability to work.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '4. You must also complete our ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.of(context).pushNamed(AppRoutes.TERMS),
                      text: 'CONTRACTOR INSURANCE APPLICATION FORM',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' (Word format link here). *Once you complete it, please send it to admin@carnawashapp.com.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Carnawash will activate your profile to connect you to customers once you are ready to go to start working with our supervisors.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'You will be able to access and receive our start-up pack from your app after you are approved by our supervisors to work independently.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "If you have any queries, please don't hesitate to contact us at admin@carnawashapp.com or call 1300 807 389 (press 3 for Carnawash workers).",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Good luck!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'CARNAWASH TEAM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget partTwo(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                n = 1;
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  circularIndex('1', oneTrue),
                  circularIndex('2', twoTrue),
                  circularIndex('3', threeTrue),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Quiz',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text('Watch the video and answer the quiz below'),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Carnawash Video',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circularIndex(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget partThree(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                if (questionValue == 0) {
                                  n = 2;
                                  oneTrue = true;
                                  twoTrue = false;
                                  threeTrue = false;
                                } else {
                                  questionValue--;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  circularIndex('1', oneTrue),
                  circularIndex('2', twoTrue),
                  circularIndex('3', threeTrue),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Questions',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: (questionValue < questionList.length / 4 && n == 3)
                    ? List.generate(
                  chunk(questionList, 4)[questionValue].length,
                      (index) {
                    return questionBox(
                      context,
                      chunk(questionList, 4)[questionValue][index],
                      index,
                    );
                  },
                )
                    : const [SizedBox(height: 16)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<List<dynamic>> chunk(List<dynamic> array, int size) {
    List<List<dynamic>> chunks = [];
    int i = 0;
    while (i < array.length) {
      int j = i + size;
      chunks.add(array.sublist(i, j > array.length ? array.length : j));
      i = j;
    }
    return chunks;
  }

  Column questionBox(
    BuildContext context,
    List quest,
    int n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          n.toString() + '. ' +  quest[0].question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            quest[0].alternatives_list.split(';').length,
            (index) {
              return ListTile(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                title: Text(
                  quest[0].alternatives_list.split(';')[index],
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: index,
                  groupValue: questionList[n][1],
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => Colors.black,
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (quest[0].alternatives_list.split(';')[index] ==
                          quest[0].answer) {
                        questionList[n][1] = 1;
                      } else {
                        questionList[n][1] = 0;
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget partFour(BuildContext context) {
    WasherProvider washerProvider = Provider.of(context);

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                n = 3;
                                oneTrue = true;
                                twoTrue = false;
                                threeTrue = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  circularIndex('1', oneTrue),
                  circularIndex('2', twoTrue),
                  circularIndex('3', threeTrue),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Quiz',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              washerProvider.quizGrade >= 80
                  ? Text(
                      'Congratulations!\nYou got ${washerProvider.quizGrade}% of the quiz right.')
                  : Text(
                      'Unfortunately, you got less than 80% correct on the quiz.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget partFourHalf(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                n = 4;
                                oneTrue = true;
                                twoTrue = false;
                                threeTrue = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  circularIndex('1', oneTrue),
                  circularIndex('2', twoTrue),
                  circularIndex('3', threeTrue),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Contractor Insurance',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text('Attach your insurance contract here'),
              const SizedBox(height: 16),
              //
              geralIconTextInput(
                context: context,
                text: "Insurance Contract",
                textController: insuranceController,
                icon: Icons.file_download_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget partFive(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                n = 10;
                                oneTrue = false;
                                twoTrue = true;
                                threeTrue = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  circularIndex('1', oneTrue),
                  circularIndex('2', twoTrue),
                  circularIndex('3', threeTrue),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Set your current availability',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              timeAvailableBox(context, timeAvailable.sunday_list, 0),
              timeAvailableBox(context, timeAvailable.monday_list, 1),
              timeAvailableBox(context, timeAvailable.tuesday_list, 2),
              timeAvailableBox(context, timeAvailable.wednesday_list, 3),
              timeAvailableBox(context, timeAvailable.thursday_list, 4),
              timeAvailableBox(context, timeAvailable.friday_list, 5),
              timeAvailableBox(context, timeAvailable.saturday_list, 6),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeAvailableBox(
    BuildContext context,
    TimeAvailableChangeModel timeAvailable,
    int index,
  ) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 189, 58, 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Colors.white),
                ),
                Text(
                  timeAvailable.day,
                ),
                IconButton(
                  splashColor: Colors.white,
                  splashRadius: 10,
                  icon: Icon(!isOpen[index]
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_down),
                  onPressed: () {
                    setState(() {
                      isOpen[index] = !isOpen[index];
                    });
                  },
                )
              ],
            ),
          ),
        ),
        isOpen[index]
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Time'),
                          GestureDetector(
                            onTap: () {
                              _selectTime(timeAvailable.start);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  '${timeAvailable.start.hour}:${timeAvailable.start.minute}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Finish Time'),
                          GestureDetector(
                            onTap: () {
                              _selectTime(timeAvailable.finish);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  '${timeAvailable.finish.hour}:${timeAvailable.finish.minute}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Break Time'),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(timeAvailable.breakpoint);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Text(
                                      '${timeAvailable.breakpoint.hour}:${timeAvailable.breakpoint.minute}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Pause Time'),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(timeAvailable.pause);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Text(
                                      '${timeAvailable.pause.hour}:${timeAvailable.pause.minute}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget partSix(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(237, 189, 58, 1),
                          child: IconButton(
                            iconSize: 24,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              setState(() {
                                n = 5;
                                oneTrue = false;
                                twoTrue = false;
                                threeTrue = true;
                              });
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'First Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  notificationGeralButtonComponent(context),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                    Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 40,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Information Sent!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Our team will update your details and will contact you shortly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
