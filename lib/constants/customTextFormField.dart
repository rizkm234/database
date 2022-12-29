import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom_textField extends StatelessWidget {
  IconData textIcon;
  String? hint_text;
  custom_textField({
    required this.textIcon,
    required this.hint_text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
        hintText: hint_text,
        prefixIcon:Align(
          widthFactor: 1,
          heightFactor: 1,
          child: Icon(textIcon),
        ) ,
        focusColor: Colors.black,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
