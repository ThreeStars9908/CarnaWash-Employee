// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController abnController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  bool edit = false;

  // CHANGE DOC TO BLOB

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UserProvider userProvider = Provider.of(
        context,
        listen: false,
      );
      WasherProvider washerProvider = Provider.of(
        context,
        listen: false,
      );

      await userProvider.loadPerfil(context);
      await washerProvider.loadBankInfo(context);
      await washerProvider.loadWasherInfo(context);

      nameController.text = userProvider.perfil.name;
      emailController.text = userProvider.perfil.email;
      phoneController.text = userProvider.perfil.phone;
      addressController.text = userProvider.perfil.address;

      abnController.text = washerProvider.washerInfo.abn;
      bankController.text = washerProvider.bankInfo.bank_name;
      accountNameController.text = washerProvider.bankInfo.account_name;
      accountNumberController.text = washerProvider.bankInfo.account_number;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    WasherProvider washerProvider = Provider.of(
      context,
      listen: false,
    );

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
                          const Text(
                            'My Account Information',
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
                  !edit
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Basic information info',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: nameController.text,
                              textController: nameController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: emailController.text,
                              textController: emailController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: phoneController.text,
                              textController: phoneController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: addressController.text,
                              textController: addressController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: abnController.text,
                              textController: abnController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: "Driver's Licence number or passport",
                            ),
                            geralInativeIconTextInput(
                              icon: Icons.upload_file,
                              context: context,
                              text: "Original Photo",
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Bank Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: bankController.text,
                              textController: bankController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: accountNameController.text,
                              textController: accountNameController,
                            ),
                            geralInativeTextInput(
                              context: context,
                              text: accountNumberController.text,
                              textController: accountNumberController,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  edit = true;
                                });
                              },
                              child: const Text(
                                'Edit Information',
                                style: TextStyle(
                                  color: Color.fromRGBO(237, 189, 58, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Basic information info',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            geralTextInput(
                              context: context,
                              text: 'Name',
                              textController: nameController,
                            ),
                            geralTextInput(
                              context: context,
                              text: 'E-mail',
                              textController: emailController,
                            ),
                            geralTextInput(
                              context: context,
                              text: 'Phone Number',
                              textController: phoneController,
                            ),
                            geralTextInput(
                              context: context,
                              text: 'Address',
                              textController: addressController,
                            ),
                            geralTextInput(
                              context: context,
                              text: 'ABN',
                              textController: abnController,
                            ),
                            //
                            geralTextInput(
                              context: context,
                              text: "Driver's Licence number or passport",
                              textController: licenceController,
                            ),
                            //
                            geralIconTextInput(
                              icon: Icons.upload_file,
                              context: context,
                              text: "Original Photo",
                              textController: photoController,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Bank Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            geralTextInput(
                              context: context,
                              text: "Bank Name",
                              textController: bankController,
                            ),
                            geralTextInput(
                              context: context,
                              text: "Account Name",
                              textController: accountNameController,
                            ),
                            geralTextInput(
                              context: context,
                              text: "Account Number",
                              textController: accountNumberController,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(MediaQuery.of(context).size.width * 0.85,
                                      50),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(237, 189, 58, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await userProvider.updatePerfil(
                                  context,
                                  UserCompleteModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      address: addressController.text),
                                );
                                await washerProvider.updateBankInfo(
                                  context,
                                  BankInfoModel(
                                    bank_name: bankController.text,
                                    account_name: accountNameController.text,
                                    account_number:
                                        accountNumberController.text,
                                  ),
                                );
                                await washerProvider.updateWasherInfo(
                                  context,
                                  WasherInfoModel(
                                    abn: abnController.text,
                                    driver_licence: licenceController.text,
                                    // picture: photoController,
                                  ),
                                );
                                setState(() {
                                  edit = false;
                                });
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
