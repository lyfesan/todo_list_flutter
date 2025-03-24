import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_flutter/data/data.dart';
import 'package:todo_list_flutter/utils/utils.dart';
import 'package:todo_list_flutter/widgets/widgets.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    this.onCompleted
  });

  final Task task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final style = context.textTheme;

    final textDecoration =
    task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;
    final double iconAlphaValue = task.isCompleted ? 0.3 : 0.5;
    final double backgroundAlphaValue = task.isCompleted ? 0.1 : 0.3;

    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 10,
          top: 10,
          bottom: 10
      ),
      child: Row(
          children: [
            CircleContainer(
              color: task.category.color.withValues(alpha: backgroundAlphaValue),
              child: Icon(
                task.category.icon,
                color: task.category.color.withValues(alpha: iconAlphaValue),
              ),
            ),
            Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: style.titleMedium?.copyWith(
                      fontWeight: fontWeight,
                      fontSize: 20,
                      decoration: textDecoration,
                    ),
                  ),
                  Text(
                    task.time,
                    style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: task.isCompleted,
              onChanged: onCompleted,
            ),
          ]
      ),
    );
  }
}
