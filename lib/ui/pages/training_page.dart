import 'package:app_employee/data/models/models.dart';
import 'package:app_employee/infra/providers/training_provider.dart';
import 'package:app_employee/ui/pages/training_module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart';

class TrainingPage extends StatefulWidget{
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}
class _TrainingPageState extends State<TrainingPage> with WidgetsBindingObserver{

  late TrainingProvider trainingProvider;
  late List<TrainingTypeModel?> listTraining;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      trainingProvider = Provider.of(
        context,
        listen: false,
      );
      await trainingProvider.loadTrainingTypes(context);
      listTraining = trainingProvider.trainingTypes;
      setState(() {});
    });
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('page resumed----$state');
    if (state == AppLifecycleState.resumed) {
      print('page resumed----');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        trainingProvider = Provider.of(
          context,
          listen: false,
        );
        await trainingProvider.loadTrainingTypes(context);
        listTraining = trainingProvider.trainingTypes;
        setState(() {});
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (listTraining == null) {
      // Display a loading state or return an empty widget
      return CircularProgressIndicator();
    }
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
                  Column(
                    children: List.generate(
                      listTraining.length,
                          (index) {
                        return trainingBox(
                          context, listTraining[index]!, listTraining[index]!.name, listTraining[index]!.progress.toString(),
                        );
                      },
                    ),
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
      TrainingTypeModel model_idx,
      String text,
      String completePercent,
      ) {
    return GestureDetector(
      onTap: (){
        print(text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingModulePage(model_idx.id,text),
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
                        '$completePercent%',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: int.parse(completePercent) >= 50 ? Colors.green : Colors.red,
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