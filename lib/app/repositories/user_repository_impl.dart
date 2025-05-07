import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/core/exceptions/exceptions.dart';
import 'package:todo_list_provider/app/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: 'Senha muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(message: 'Email já cadastrado');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'Email inválido');
      } else {
        throw AuthException(message: 'Erro ao cadastrar usuário');
      }
    } catch (e, s) {
      log(e.toString(), error: s);
      throw AuthException(message: e.toString());
    }
  }
}
