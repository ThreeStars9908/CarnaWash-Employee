import 'package:flutter/material.dart';

import '../ui.dart';

class SupplyPage extends StatefulWidget {
  const SupplyPage({super.key});

  @override
  State<SupplyPage> createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
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
                        'My Suppliers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Find your main suppliers here',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  supplyBox(
                    context,
                    'Work Manual',
                  ),
                  supplyBox(
                    context,
                    'Tyre Shine',
                  ),
                  supplyBox(
                    context,
                    'Interior & Tyres',
                  ),
                  supplyBox(
                    context,
                    'Exterior Waterless',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox supplyBox(
    BuildContext context,
    String text,
  ) {
    return SizedBox(
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
                child: Icon(
                  Icons.file_download_outlined,
                  size: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
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
            ],
          ),
          Divider(
            color: Colors.grey[600]!,
          ),
        ],
      ),
    );
  }
}
