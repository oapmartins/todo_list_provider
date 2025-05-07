import 'package:todo_list_provider/app/core/exceptions/exceptions.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  RegisterController(this._userService);
  final UserService _userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao cadastrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
