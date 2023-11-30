// ignore_for_file: no_logic_in_create_state, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class WalletEditPage extends StatefulWidget {
  CardModel? preData;
  WalletEditPage({
    super.key,
    this.preData,
  });

  @override
  State<WalletEditPage> createState() => _WalletEditPageState();
}

class _WalletEditPageState extends State<WalletEditPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController holderController = TextEditingController();
  TextEditingController expiresController = TextEditingController();
  late bool edit;

  @override
  void initState() {
    super.initState();

    if (widget.preData != null) {
      edit = true;
      holderController.text = widget.preData!.name;
      expiresController.text = widget.preData!.date;
    } else {
      edit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context, listen: false);

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          backButtonComponent(context),
                          Text(
                            edit ? 'Edit Credit Card' : 'Register Credit Card',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          geralTextInput(
                            context: context,
                            text: 'Number',
                            textController: numberController,
                          ),
                          geralTextInput(
                            context: context,
                            text: 'Cardholder Name',
                            textController: holderController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              geralTextInput(
                                context: context,
                                text: 'Expires',
                                textController: expiresController,
                              ),
                            ],
                          ),
                          edit
                              ? GestureDetector(
                                  onTap: () async {
                                    showDialog<void>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to DELETE this card?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: const Text(
                                                      'Confirm Delete'),
                                                  content: const Text(
                                                      'Are you sure you want to DELETE this card?'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('Ok'),
                                                      onPressed: () async =>
                                                          await walletProvider
                                                              .deleteCard(
                                                        context,
                                                        widget.preData!.id!,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Delete this credit card',
                                    style: TextStyle(
                                      color: Color.fromRGBO(237, 189, 58, 1),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                        onPressed: () async {
                          if (holderController.text != '' &&
                              numberController.text != '' &&
                              expiresController.text != '') {
                            edit
                                ? await walletProvider.updateCard(
                                    context,
                                    CardCreateUpdateModel(
                                      name: holderController.text,
                                      card: numberController.text,
                                      date: expiresController.text,
                                    ),
                                  )
                                : await walletProvider.createCard(
                                    context,
                                    CardCreateUpdateModel(
                                      name: holderController.text,
                                      card: numberController.text,
                                      date: expiresController.text,
                                    ),
                                  );
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text('All fields need to be filled!'),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {},
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
