import 'package:todo_list_provider/app/core/dabase/migrations/migration.dart';
import 'package:todo_list_provider/app/core/dabase/migrations/migration_v1.dart';
import 'package:todo_list_provider/app/core/dabase/migrations/migration_v2.dart';
import 'package:todo_list_provider/app/core/dabase/migrations/migration_v3.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [MigrationV1(), MigrationV2(), MigrationV3()];
  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }

    if (version == 2) {
      migrations.add(MigrationV3());
    }

    return migrations;
  }
}
