import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget geralTextInput({
  required BuildContext context,
  required String text,
  required TextEditingController textController,
  TextInputType type = TextInputType.text,
  double larg = 0.85,
}) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * larg,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
          ),
          controller: textController,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget geralMultilineTextInput({
  required BuildContext context,
  required String text,
  required TextEditingController textController,
  TextInputType type = TextInputType.text,
}) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
          ),
          controller: textController,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget geralInativeTextInput({
  required BuildContext context,
  TextEditingController? textController,
  String? text,
  double larg = 0.85,
}) {
  TextEditingController unable = TextEditingController();
  if (textController != null) {
    unable.text = text!;
  }

  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * larg,
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: text ?? '',
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          controller: textController ?? unable,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

Widget geralIconTextInput({
  required BuildContext context,
  required String text,
  required TextEditingController textController,
  required IconData icon,
  TextInputType type = TextInputType.text,
  double larg = 0.85,
}) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * larg,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
          ),
          controller: textController,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget geralInativeIconTextInput({
  required BuildContext context,
  required String text,
  required IconData icon,
  double larg = 0.85,
}) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * larg,
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget chatTextInput({
  required BuildContext context,
  required String text,
  required TextEditingController textController,
  TextInputType type = TextInputType.text,
  double larg = 0.7,
}) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * larg,
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
          ),
          controller: textController,
        ),
      ),
    ],
  );
}

Widget passwordTextInput(
  BuildContext context,
  TextEditingController textController,
  Function func,
  bool hidden,
) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          obscureText: hidden,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => func,
                icon: const Icon(Icons.remove_red_eye_outlined)),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: 'Password',
          ),
          controller: textController,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget passwordConfirmTextInput(
  BuildContext context,
  TextEditingController textController,
) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: 'Confirm Password',
          ),
          controller: textController,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget geralDateInput({
  required BuildContext context,
  required String text,
  required TextEditingController textController,
}) {
  var maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: TextFormField(
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: 'mm/dd/yyyy',
            labelText: text,
          ),
          controller: textController,
          inputFormatters: [maskFormatter],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
