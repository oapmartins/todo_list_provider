import 'package:todo_list_provider/app/core/dabase/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repisotry.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory})
    : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'description': description,
      'created_at': date.toIso8601String(),
      'is_finished': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select *
      from todo
      where created_at between ? and ?
      order by created_at
    ''',
      [startFilter.toIso8601String(), endFilter.toIso8601String()],
    );
    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final finished = task.finished ? 1 : 0;

    await conn.rawUpdate('update todo set is_finished = ? where id = ?', [finished, task.id]);
  }
}
