import 'package:flutter/material.dart';

import '../../ui.dart';

class ChangePassComponent extends StatefulWidget {
  const ChangePassComponent({
    super.key,
  });

  @override
  State<ChangePassComponent> createState() => _ChangePassComponentState();
}

class _ChangePassComponentState extends State<ChangePassComponent> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passConfirmController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Reset your Password',
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
                textController: emailController,
              ),
              passwordTextInput(
                context,
                passwordController,
                () => setState(
                  () {
                    hidden = !hidden;
                  },
                ),
                hidden,
              ),
              passwordConfirmTextInput(
                context,
                passConfirmController,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(237, 189, 58, 1),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50)),
            onPressed: () {},
            child: const Text('Next'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Back",
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "By creating an account I agree to the terms and conditions of our Terms of Service.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
