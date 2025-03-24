import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter/data/data.dart';
import 'package:todo_list_flutter/providers/providers.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});