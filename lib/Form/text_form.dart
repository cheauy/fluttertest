import 'dart:ffi';

import 'package:flutter/material.dart';


class TextForm extends StatefulWidget {
 final TextEditingController? controller;
  final String? richtext;
  final String? hint;
  final Icon? icon;
  final bool readonly;
  final int? maxline;
  final void Function()? onTap;
  final String? Function(String?)? validator;


  const TextForm(
      {Key? key,
       this.controller,
        this.richtext,
        this.icon,
        this.maxline,
        this.hint,
        required this.readonly,
        this.onTap,
        this.validator}): super(key: key);


  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.richtext,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .black, // Ensure the text color matches your design
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Set the asterisk color to red
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          readOnly: widget.readonly,
          maxLines: widget.maxline,
          validator: widget.validator,
          onTap: widget.onTap,
          // keyboardType: widget.keyboardType,
          controller: widget.controller ,

          decoration: InputDecoration(
              errorStyle: TextStyle(height: 1),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.amber, width: 2)),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: widget.hint,
              suffixIcon: widget.icon

              // hintStyle: TextStyle(fontFamily: fontFamily),
              // labelStyle: TextStyle(fontFamily: fontFamily,fontWeight: FontWeight.bold),

          ),
        ),
      ],
    );}}