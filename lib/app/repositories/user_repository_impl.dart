import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      log(e.toString(), error: s);
      throw AuthException(message: 'Erro ao fazer login');
    } on FirebaseAuthException catch (e, s) {
      log(e.toString(), error: s);
      if (e.code == 'wrong-password' ||
          e.code == 'invalid-email' ||
          e.code == 'invalid-credential' ||
          e.code == 'user-not-found') {
        throw AuthException(message: 'Login ou senha inválidos');
      } else if (e.code == 'operation-not-allowed') {
        throw AuthException(message: 'Operação não permitida');
      } else {
        throw AuthException(message: 'Erro ao fazer login');
      }
    } catch (e, s) {
      log(e.toString(), error: s);
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e, s) {
      log(e.toString(), error: s);
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSigning = GoogleSignIn();
      final googleAccount = await googleSigning.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        throw AuthException(message: 'Erro ao fazer login com o Google');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: 'Conta já existe com outro provedor');
      } else if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Credencial inválida');
      } else if (e.code == 'operation-not-allowed') {
        throw AuthException(message: 'Operação não permitida');
      } else {
        throw AuthException(message: 'Erro ao fazer login com o Google');
      }
    } on AuthException catch (e, s) {
      log(e.toString(), error: s);
      throw AuthException(message: e.message);
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    return _firebaseAuth.signOut();
  }

  @override
  Future<User?> updateName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: name);
      user.reload();
    } else {
      throw AuthException(message: 'Usuário não encontrado');
    }
    return null;
  }
}
