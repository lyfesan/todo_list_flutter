import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter/data/data.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.read(taskDatasourceProvider);
  return TaskRepositoryImplementation(datasource);
});