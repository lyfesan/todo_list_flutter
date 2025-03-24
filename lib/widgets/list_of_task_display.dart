import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter/providers/providers.dart';
import 'package:todo_list_flutter/utils/utils.dart';
import 'package:todo_list_flutter/data/data.dart';
import 'package:todo_list_flutter/widgets/widgets.dart';

class ListOfTaskDisplay extends ConsumerWidget {
  const ListOfTaskDisplay({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final colors = context.colorScheme;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksAlert = isCompletedTasks
        ? 'There is no completed task yet'
        : 'Hurray there is no task to do :)';

    return Container(
      width: deviceSize.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors.primaryContainer,
      ),
      child: tasks.isEmpty
          ? Center(
            child: Text(
              emptyTasksAlert,
              style: context.textTheme.headlineSmall,
            )
          )
          : ListView.separated(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder:(ctx, index) {
              final task = tasks[index];
              return InkWell(
                onLongPress: (){
                  AppAlerts.showAlertDeleteDialog(
                      context: context,
                      ref: ref,
                      task: task,
                  );
                },
                onTap: () async {
                  await showModalBottomSheet(
                    context: context, builder: (ctx) {
                      return TaskDetails(task: task);
                    }
                  );
                },
                child: TaskTile(
                  task: task,
                  onCompleted: (value) async {
                    await ref.read(tasksProvider.notifier)
                        .updateTask(task)
                        .then((value) {
                          AppAlerts.displaySnackbar(
                            context,
                            task.isCompleted
                                ? 'Task incompleted'
                                : 'Task completed',
                          );
                        });
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 1.5);
            },
          )
    );
  }
}
