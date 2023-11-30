import 'package:app_employee/ui/pages/training_module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui.dart';

class ProductsPage extends StatefulWidget{
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {
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
                        'Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Column(children: [
                        Text(
                          'Number of Washes',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 28,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 32),
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