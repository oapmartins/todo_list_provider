import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_page.dart';
import 'package:todo_list_provider/app/services/user_service.dart';

class AuthModule extends TodoListModule {
  AuthModule()
    : super(
        routers: {
          '/login': (context) => LoaderOverlay(child: const LoginPage()),
          '/register': (context) => LoaderOverlay(child: const RegisterPage()),
        },
        bindings: [
          ChangeNotifierProvider<LoginController>(
            create: (context) => LoginController(context.read<UserService>()),
          ),
          ChangeNotifierProvider<RegisterController>(
            create: (context) => RegisterController(context.read<UserService>()),
          ),
        ],
      );
}
