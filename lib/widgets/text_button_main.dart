import 'package:flutter/material.dart';
import 'package:todo_list_flutter/utils/extensions.dart';
import 'widgets.dart';
import 'display_color_text.dart';

class TextButtonMain extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const TextButtonMain ({
    super.key,
    this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return FilledButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: DisplayColorText(
            text: text,
            fontSize: 15,
          ),
        )
    );
  }
}
