import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui.dart';
import 'package:video_player/video_player.dart';
class TrainingModulePage extends StatefulWidget{
  final String moduleName;
  const TrainingModulePage(this.moduleName);

  @override
  State<TrainingModulePage> createState() => _TrainingModulePageState();
}
class _TrainingModulePageState extends State<TrainingModulePage> {

  late VideoPlayerController _controller;
  int n = 1;
  List<Map<String, dynamic>> questionList = [
    {
      'key': '1',
      'question': '1What is the capital of Paris?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '2',
      'question': '2What is the capital of Madrid?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '3',
      'question': '3What is the capital of Rome?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '4',
      'question': '4What is the capital of Berlin?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '5',
      'question': '5What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '6',
      'question': '6What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '7',
      'question': '7What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '8',
      'question': '8What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '9',
      'question': '9What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
    {
      'key': '10',
      'question': '10What is the capital of France?',
      'alternatives': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selectedAnswer' : -1,
    },
  ];
  int questionValue = 0;
  double correct_percentage = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    ..initialize().then((_) {
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {
      _controller.play();
    });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBarComponent(context),
      body: (n== 1)
          ? partOne(context)
          : n ==2
          ? partThree(context)
          : n == 3
          ? partFour(context):partOne(context)
    );
  }
  Widget partOne(BuildContext context){
    return SingleChildScrollView(
      child: Center(
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
                        backButtonComponent(context),
                        Text(
                          widget.moduleName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    notificationGeralButtonComponent(context),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Introducing the module and explaining the video briefly.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ) : Container(),
                const SizedBox(height: 32),
                const Text(
                  'Text explaining briefly what this module is about and what the questions will'
                      ' cover and that the quiz will count to having a certified washer profile.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.85, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(237, 189, 58, 1),
                    ),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      n = 2;
                    });
                  },
                  child: const Text(
                    'Start questions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'You can always come back and try again or answer later, your progress wil be saved.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  GestureDetector trainingBox(
      BuildContext context,
      String text,
      String completePercent,
      ) {
    return GestureDetector(
      onTap: (){
        print(text);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 8,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.cube,
                    size: 30,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        completePercent,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.green
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.grey[600]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget partThree(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
                            backgroundColor: const Color.fromRGBO(237, 189, 58, 1),
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
                                  } else {
                                    questionValue--;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          widget.moduleName,
                          style: const TextStyle(
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
                const SizedBox(height: 16),
                const Text(
                  'Questions',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: List.generate(
                    chunk(questionList, 5)[questionValue].length,
                        (index) {
                      return questionBox(context,
                          chunk(questionList, 5)[questionValue][index], index + questionValue * 5);
                    },
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.85, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(237, 189, 58, 1),
                    ),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (questionValue < chunk(questionList, 5).length - 1) {
                      setState(() {
                        // Move to the next set of questions
                        questionValue++;
                      });
                    }
                    else{
                      setState(() {
                        calculatePercentage();
                        n = 3;
                      });
                    }
                    // setState(() {
                    //   questionValue ++;
                    // });
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
    print(chunks);
    return chunks;
  }

  Column questionBox(
      BuildContext context,
      Map<String, dynamic> quest,
      int n,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${n + 1}. ${quest['question']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            quest['alternatives'].length,
                (index) {
              final bool isSelected = questionList[n]['selectedAnswer'] == index;
              return ListTile(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                title: Text(
                  quest['alternatives'][index],
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                leading: Radio(
                  value: index,
                  groupValue: questionList[n][1],
                  activeColor: Colors.blue,
                  fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black,
                  ),
                  onChanged: (value) {
                    setState(() {
                      questionList[n]['selectedAnswer'] = value; // Update selected answer
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

  Widget partFour(BuildContext context){
    return SingleChildScrollView(
      child: Center(
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
                        backButtonComponent(context),
                        Text(
                          widget.moduleName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    notificationGeralButtonComponent(context),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Quiz',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 32,),
                Text(
                  correct_percentage >= 80 ? 'Congratulations!\nYou got ${correct_percentage}% of the quiz right.'
                      : 'Unfortunately, you got less than 80% correct on the quiz.',
                  style: TextStyle(
                    fontSize: 16,
                    color: correct_percentage >= 80 ? Colors.blue : Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.85, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(237, 189, 58, 1),
                    ),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      n = correct_percentage >= 80 ? 4 : 2; // Change to the next module or watch video again
                    });
                  },
                  child: Text(
                    correct_percentage >= 80 ? 'Next Module' : 'Watch Video Again',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      correct_percentage >= 80 ? 'Go back to training area' : 'Try again later',
                      style: const TextStyle(
                        color: Color.fromRGBO(237, 189, 58, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void calculatePercentage() {
    int correctAnswers = 0;
    for (var question in questionList) {
      print('ssss' + question['alternatives'][question['selectedAnswer']]);
      if (question['selectedAnswer'] != null &&
          question['alternatives'][question['selectedAnswer']] == question['answer']) {
        correctAnswers++;
      }
    }
    setState(() {
      correct_percentage = (correctAnswers / questionList.length) * 100;
    });
  }
}