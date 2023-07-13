import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ColorConsts.dart';
import '../helpers/TextStyles.dart';


class MyTextFormField extends StatelessWidget {
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
   MyTextFormField({
    Key? key,
    this.label,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.hintText,
    this.focusNode,
    this.onFieldSubmitted,

  }) : super(key: key);

  OutlineInputBorder border({Color color = appPrimary, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              "$label",
              style: MyTextStyle.semiBold.copyWith(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            focusNode: focusNode,
            controller: controller,
            cursorColor: appPrimary,
            cursorHeight: 25,
            validator: validator,
            maxLength: maxLength,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: MyTextStyle.regular.copyWith(
              fontSize: 18,
              color: appPrimary,
            ),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: MyTextStyle.regular.copyWith(
                color: appPrimary.withOpacity(0.5),
                fontSize: 15,
              ),
              border: border(
                width: 0.75,
              ),
              focusedBorder: border(
                color: appPrimary,
                width: 1.2,
              ),
              disabledBorder: border(
                width: 0.75,
              ),
              enabledBorder: border(
                width: 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}