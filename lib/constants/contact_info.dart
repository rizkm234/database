import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customTextFormField.dart';

class contactInfo extends StatelessWidget {
  TextEditingController dbController ;
  double container_width;
  String? hint_text;
  IconData textIcon;
  contactInfo({
    required this.container_width,
    required this.hint_text,
    required this.textIcon,
    required this.dbController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: container_width,
            child: TextFormField(
                controller: dbController,
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
            ),
          ),
        // const SizedBox(width: 10,),
        // Container(
        //     width: MediaQuery.of(context).size.width/3,
        //     child: custom_textField(textIcon: Icons.person, hint_text: 'Last Name',)),
      ],
    );
  }
}

