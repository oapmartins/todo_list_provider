import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
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
              TodoCardFilter(label: 'HOJE', taskFilter: TaskFilterEnum.today, selected: true),
              TodoCardFilter(label: 'AMANHÃ', taskFilter: TaskFilterEnum.tomorrow, selected: false),
              TodoCardFilter(label: 'SEMANA', taskFilter: TaskFilterEnum.week, selected: true),
            ],
          ),
        ),
      ],
    );
  }
}
