import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_flutter/config/config.dart';
import 'package:todo_list_flutter/utils/utils.dart';
import 'package:todo_list_flutter/widgets/widgets.dart';
import 'package:todo_list_flutter/data/data.dart';
import 'package:todo_list_flutter/providers/providers.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(tasksProvider);
    final incompletedTasks = _incompletedTask(taskState.tasks, ref);
    final completedTasks = _completedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:() => Helpers.selectDate(context, ref),
                      child: DisplayColorText(
                        text: DateFormat('dd MMMM yyyy').format(selectedDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Gap(10),
                    DisplayColorText(
                      text: 'What Task Should We do?',
                      fontSize: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListOfTaskDisplay(
                        tasks: incompletedTasks,
                    ),
                    Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineSmall,
                      textAlign: TextAlign.left,
                    ),
                    ListOfTaskDisplay(
                      tasks: completedTasks,
                      isCompletedTasks: true,
                    ),
                    //Gap(20),
                    /*
                    FilledButton(
                      onPressed: (){},
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayColorText(
                          text: 'Add New Task',
                          fontSize: 15,
                        ),
                      )
                    ),
                    */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(RouteLocation.createTask),
          child: Icon(Icons.add),
      ),
    );
  }
  List<Task> _incompletedTask(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> filteredTask = [];

    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }

  List<Task> _completedTask(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> filteredTask = [];

    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }

}