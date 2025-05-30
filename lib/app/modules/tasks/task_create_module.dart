import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/dabase/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:todo_list_provider/app/repositories/tasks/task_repository_impl.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repisotry.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service_impl.dart';

class TaskCreateModule extends TodoListModule {
  TaskCreateModule()
    : super(
        bindings: [
          Provider<TasksRepository>(
            create:
                (context) =>
                    TasksRepositoryImpl(sqliteConnectionFactory: context.read<SqliteConnectionFactory>()),
          ),
          Provider<TasksService>(
            create: (context) => TasksServiceImpl(tasksRepository: context.read<TasksRepository>()),
          ),
          ChangeNotifierProvider(
            create: (context) => TaskCreateController(tasksService: context.read<TasksService>()),
          ),
        ],
        routers: {
          '/task/create': (context) => TaskCreatePage(controller: context.read<TaskCreateController>()),
        },
      );
}
