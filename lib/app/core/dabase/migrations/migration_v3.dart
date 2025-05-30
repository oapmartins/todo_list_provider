import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/dabase/migrations/migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE todo3 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description varchar(500) NOT NULL,
        created_at datetime,
        is_finished INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
}
