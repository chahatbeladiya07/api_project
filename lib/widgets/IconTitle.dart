

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ColorConsts.dart';
import '../helpers/TextStyles.dart';

class IconsTitle extends StatelessWidget {
  String? svgPath,Icon;
  final String title;
  final double height,width;
  IconsTitle({super.key,this.svgPath,this.Icon, required this.title, this.height=22,  this.width=22,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize:MainAxisSize.min,
      children: [
        svgPath!=null ?
        SvgPicture.asset(
          svgPath!,
          height: height,
          width: width,
          colorFilter: ColorFilter.mode(appPrimary, BlendMode.srcIn),
        ) : Icon !=null ?Image.asset(Icon!,height: height,width: height,color:appPrimary,) : const SizedBox.shrink(),
        const SizedBox(width: 8,),
        Flexible(
          child: Text(
            title,
            style: MyTextStyle.medium.copyWith(color: black, fontSize: 15),
            overflow: TextOverflow.visible,
          ),
        )
      ],
    );
  }
}

