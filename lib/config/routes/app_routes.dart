import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_flutter/config/routes/routes.dart';
import 'package:todo_list_flutter/screens/create_task_screen.dart';
import 'package:todo_list_flutter/screens/home_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  )
];