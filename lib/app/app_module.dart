import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:todo_list_provider/app/core/dabase/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/repositories/user_repository.dart';
import 'package:todo_list_provider/app/repositories/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/user_service.dart';
import 'package:todo_list_provider/app/services/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuth>(create: (_) => FirebaseAuth.instance),
        Provider<SqliteConnectionFactory>(create: (_) => SqliteConnectionFactory(), lazy: false),
        Provider<UserRepository>(create: (context) => UserRepositoryImpl(context.read<FirebaseAuth>())),
        Provider<UserService>(create: (context) => UserServiceImpl(context.read<UserRepository>())),
        ChangeNotifierProvider<AuthProviderApp>(
          create:
              (context) =>
                  AuthProviderApp(context.read<FirebaseAuth>(), context.read<UserService>())..loadListener(),
          lazy: false,
        ),
      ],
      child: AppWidget(),
    );
  }
}
