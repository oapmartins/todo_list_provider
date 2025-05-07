import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final controller = context.read<RegisterController>();
    final defaultListener = DefaultListenerNotifier(controller);
    defaultListener.listener(
      context: context,
      onSuccess: (notifier, listenerNotifier) {
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios_new, size: 20, color: context.primaryColor),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Todo list', style: TextStyle(fontSize: 10, color: context.primaryColor)),
            Text('Cadastro', style: TextStyle(fontSize: 15, color: context.primaryColor)),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: FittedBox(fit: BoxFit.fitHeight, child: TodoListLogo()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'Email',
                    controller: _emailController,
                    validator: Validatorless.multiple([
                      Validatorless.email('Email inválido'),
                      Validatorless.required('Email obrigatório'),
                    ]),
                  ),
                  SizedBox(height: 20),
                  TodoListField(
                    label: 'Senha',
                    controller: _passwordController,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
                    ]),
                  ),
                  SizedBox(height: 20),
                  TodoListField(
                    label: 'Confirmar Senha',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma senha obrigatória'),
                      Validatorless.compare(_passwordController, 'As senhas não conferem'),
                    ]),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<RegisterController>().registerUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Salvar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
