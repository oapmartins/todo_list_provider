import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(scale: animation, alignment: Alignment.bottomRight, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskCreateModule().getPage('/task/create', context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFAFBFE),
        iconTheme: IconThemeData(color: context.primaryColor, size: 32),
        actions: [
          PopupMenuButton(
            // onSelected: (value) => widget._controller.showOrHideFinishedTasks(),
            icon: const Icon(Icons.filter_alt, size: 32),
            itemBuilder:
                (_) => [
                  // PopupMenuItem<bool>(
                  //   value: true,
                  //   child: Text(
                  //     '${widget._controller.showFinishedTasks ? 'Esconder' : 'Mostrar'} tarefas concluídas',
                  //   ),
                  // ),
                ],
          ),
        ],
      ),
      drawer: HomeDrawer(),
      backgroundColor: const Color(0xFFFAFBFE),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        backgroundColor: context.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [HomeHeader(), HomeFilters(), HomeWeekFilter(), HomeTasks()],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
