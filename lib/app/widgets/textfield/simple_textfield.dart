import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SimpleTextfieldWidget extends StatelessWidget {
  final Widget icon;
  final String hintText;
  final String helperText;
  final String labelText;
  final Function validator;
  final Function()? onTap;
  final TextEditingController controller;

  SimpleTextfieldWidget(
      {required this.controller,
      required this.hintText,
      required this.helperText,
      required this.labelText,
      required this.icon,
      this.onTap,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: NeumorphicTheme.defaultTextColor(context),
              ),
            ),
          ),
          TextFormField(
              enableSuggestions: true,
              onTap: this.onTap,
              controller: controller,
              style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey[100]!)),
                hintText: hintText,
                //   labelText: labelText,
                helperText: helperText,
                prefixIcon: icon,
                prefixText: ' ',
              ),
              validator: (value) => validator(value)),
        ]);
  }
}
