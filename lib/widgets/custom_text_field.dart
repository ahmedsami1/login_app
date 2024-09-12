import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
    CustomTextField({
     super.key,
     this.hintText,
     this.prefixIcon,
     this.suffixIcon,
     required this.textInputType,
     this.onChanged});

   final String? hintText;
   final Icon? prefixIcon;
   final Icon? suffixIcon;
   final TextInputType textInputType;
   Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if(data!.isEmpty){
          return 'filed can\'t be empty';
        }
      },
      onChanged: onChanged,
      keyboardType: textInputType,
      decoration: InputDecoration(

          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white,),
          ),
        fillColor: Colors.grey.shade200,
          labelText: hintText,
          labelStyle: const TextStyle(
              color: Colors.black
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
      ),
    );
  }
}
