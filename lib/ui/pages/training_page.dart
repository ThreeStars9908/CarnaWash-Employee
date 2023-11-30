import 'package:app_employee/ui/pages/training_module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui.dart';

class TrainingPage extends StatefulWidget{
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}
class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBarComponent(context),
      body: SingleChildScrollView(
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
                    children: [
                      backButtonComponent(context),
                      const Text(
                        'Training area',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Text explaining what this area is for and how it can improve the washer’s skills and results.'
                        ' Also that the rest of the modules unlock if they get a certain percentage right in the '
                        'questions that follow the training tutorials.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  trainingBox(
                    context,
                    'Training module I',
                    '80%'
                  ),
                  trainingBox(
                    context,
                    'Training module II',
                      '80%'
                  ),
                  trainingBox(
                    context,
                    'Training module III',
                      '80%'
                  ),
                  trainingBox(
                    context,
                    'Training module IV',
                      '80%'
                  ),
                  trainingBox(
                    context,
                    'Trainig module V',
                      '80%'
                  ),
                ],
              ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingModulePage(text),
          ),
        );
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
}