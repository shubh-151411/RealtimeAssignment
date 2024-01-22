import 'package:flutter/material.dart';
import 'package:realtime_innovations/utils/colors/colors.dart';
import 'package:realtime_innovations/utils/decoration/size_config.dart';
import 'package:realtime_innovations/utils/decoration/text_decoration.dart';

class CalenderBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backGroundColor;
  final Color? textColor;
  final String? text;
  final bool? isSelected;
  const CalenderBtn(
      {super.key,
      this.onTap,
      this.backGroundColor,
      this.textColor,
      this.text,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.height! * 0.05,
        width: SizeConfig.width! * 0.4,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          text ?? '',
          style: normalTextStyle.copyWith(color: textColor, fontSize: 14),
        ),
      ),
    );
  }
}
