// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

class SignInComponent extends StatefulWidget {
  const SignInComponent({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignInComponent> createState() => _SignInComponentState();
}

class _SignInComponentState extends State<SignInComponent> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    WasherProvider washerProvider = Provider.of(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              geralTextInput(
                context: context,
                text: 'E-mail',
                textController: widget.emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              passwordTextInput(
                context,
                widget.passwordController,
                () => setState(() {
                  hidden = !hidden;
                }),
                hidden,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(237, 189, 58, 1),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50)),
            onPressed: () async {
              await userProvider.submitLogin(
                context,
                widget.emailController.text,
                widget.passwordController.text,
              );

              int i = await washerProvider.verifyFistLogin(context);
              print('verify first lgin' + i.toString());
              if (i == 10) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(validate: true),
                  ),
                );
              } else if (i == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(validate: false),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(index: i),
                  ),
                );
              }
            },
            child: const Text('Login'),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
