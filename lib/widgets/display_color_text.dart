import 'package:flutter/material.dart';
import 'package:todo_list_flutter/utils/utils.dart';

class DisplayColorText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const DisplayColorText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: context.textTheme.headlineSmall?.copyWith(
        color: color ?? context.colorScheme.surface,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize,
        ),
    );
  }
}
