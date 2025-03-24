import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter/utils/utils.dart';
import 'package:todo_list_flutter/widgets/widgets.dart';
import 'package:todo_list_flutter/providers/providers.dart';
import 'package:todo_list_flutter/config/config.dart';
import 'package:todo_list_flutter/data/data.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      appBar: AppBar(
        title: DisplayColorText(
            text: 'Add New Task',
            color: context.colorScheme.primary
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'New Task Title',
                title: 'Title',
                controller: _titleController,
              ),
              Gap(20),
              CategoriesSelection(),
              Gap(20),
              SelectDateTime(),
              Gap(20),
              CommonTextField(
                hintText: 'Add notes/description',
                title: 'Notes',
                maxLines: 6,
                controller: _noteController,
              ),
              Gap(20),
              FilledButton(
                onPressed: _createTask,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayColorText(
                    text: 'Save',
                    fontSize: 15,
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat('dd MMMM yyyy').format(date),
        note: note,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task create successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}
