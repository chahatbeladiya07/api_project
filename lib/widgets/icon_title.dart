import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../color_consts.dart';
import '../helpers/TextStyles.dart';

// ignore: must_be_immutable
class IconsTitle extends StatelessWidget {
  String? svgPath,iconPath;
  final String title;
  final double height,width;
  IconsTitle({super.key,this.svgPath,this.iconPath, required this.title, this.height=22,  this.width=22,});

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
          colorFilter: const ColorFilter.mode(appPrimary, BlendMode.srcIn),
        ) : iconPath !=null ?Image.asset(iconPath!,height: height,width: height,color:appPrimary,) : const SizedBox.shrink(),
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

