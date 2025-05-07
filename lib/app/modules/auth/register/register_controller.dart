import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/exceptions/exceptions.dart';
import 'package:todo_list_provider/app/services/user_service.dart';

class RegisterController extends ChangeNotifier {
  RegisterController(this._userService);
  final UserService _userService;

  String? error;
  bool success = false;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao cadastrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
