import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({super.key, required this.text, this.onTap,});
   final String text;
   final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12)
      ),
      width: double.infinity,
      height: 60.0,
      child: MaterialButton(
        onPressed: onTap,
        child:  Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}