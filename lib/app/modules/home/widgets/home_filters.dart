import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTROS', style: context.titleStyle),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                selected:
                    context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.today,
                totalTasksModel: TotalTasksModel(totalTasks: 15, totalTasksFinish: 5),
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                selected:
                    context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTasksModel(totalTasks: 12, totalTasksFinish: 10),
              ),
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                selected:
                    context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.week,
                totalTasksModel: TotalTasksModel(totalTasks: 10, totalTasksFinish: 6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
