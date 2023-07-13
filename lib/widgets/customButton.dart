import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../color_consts.dart';
import '../helpers/TextStyles.dart';

class CustomButton extends StatelessWidget {
  final String svgPath,title;
  final double height,width;
  final Color color;
  const CustomButton({
    required this.svgPath,required this.title,
    this.height=22,
    this.width=22,
    this.color=black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize:MainAxisSize.min,
        children: [
          SvgPicture.asset(svgPath,height: height,width: width,colorFilter: ColorFilter.mode(color,BlendMode.srcIn)),
          const SizedBox(width: 5,),
          Text(
            title,
            style: MyTextStyle.medium.copyWith(
              color: color,
              fontSize: 14.5
            ),
          ),
        ]
    );
  }
}