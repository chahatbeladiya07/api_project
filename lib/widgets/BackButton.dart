import 'package:flutter/material.dart';
class Back_Button extends StatelessWidget {
  const Back_Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,));
  }
}
