import 'package:todo_list_provider/app/core/dabase/migrations/migration.dart';
import 'package:todo_list_provider/app/core/dabase/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [MigrationV1()];
  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];
    if (version == 1) {
      // migrations.add(MigrationV1());
    }
    return migrations;
  }
}
